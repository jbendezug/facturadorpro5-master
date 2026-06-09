#!/bin/sh
# =============================================================================
# FacturadorPro5 – Container Entrypoint
# Se ejecuta antes de php-fpm en el servicio "app".
# Los workers (queue, scheduler) lo saltan con SKIP_SETUP=true.
# =============================================================================
set -e

echo "========================================"
echo "  FacturadorPro5 – Iniciando contenedor"
echo "========================================"

# ── Saltar setup en workers ──────────────────────────────────────────────────
if [ "${SKIP_SETUP:-false}" = "true" ]; then
    echo "[setup] SKIP_SETUP=true → omitiendo inicialización."
    exec "$@"
fi

# ── Permisos de escritura ─────────────────────────────────────────────────────
# CACHE_DRIVER=redis_tenancy no funciona en CLI (necesita SERVER_NAME del request)
# Forzar 'file' para todos los comandos artisan del entrypoint.
export CACHE_DRIVER=file

echo "[setup] Ajustando permisos en storage/ y bootstrap/cache/ ..."
chown -R www-data:www-data \
    /var/www/html/storage \
    /var/www/html/bootstrap/cache 2>/dev/null || true
chmod -R 775 \
    /var/www/html/storage \
    /var/www/html/bootstrap/cache 2>/dev/null || true

# ── Directorio temporal de mPDF ───────────────────────────────────────────────
mkdir -p /var/www/html/vendor/mpdf/mpdf/tmp/mpdf
chmod -R 777 /var/www/html/vendor/mpdf/mpdf/tmp

# ── Instalar dependencias si vendor/ no existe ──────────────────────────────
if [ ! -f /var/www/html/vendor/autoload.php ]; then
    echo "[setup] vendor/ no encontrado – ejecutando composer install ..."
    composer install \
        --no-interaction \
        --no-dev \
        --optimize-autoloader \
        --prefer-dist \
        --ignore-platform-reqs \
        --no-scripts 2>&1 || echo "[setup] composer install fallo (continuando)..."
    composer dump-autoload --optimize 2>&1 || true
fi

# ── Esperar a MySQL ───────────────────────────────────────────────────────────
echo "[setup] Esperando conexión a MySQL (${DB_HOST:-mysql}:${DB_PORT:-3306}) ..."
i=1
while [ "$i" -le 30 ]; do
    php -r "
        try {
            \$pdo = new PDO(
                'mysql:host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT'),
                getenv('DB_USERNAME'),
                getenv('DB_PASSWORD')
            );
            exit(0);
        } catch (Exception \$e) {
            exit(1);
        }
    " 2>/dev/null && break
    echo "[setup] MySQL no disponible (intento $i/30), esperando 3s..."
    i=$((i + 1))
    sleep 3
done
echo "[setup] MySQL listo."

# ── Assets compilados (mix-manifest.json) ──────────────────────────────────────
if [ ! -f /var/www/html/public/mix-manifest.json ]; then
    echo "[setup] Generando mix-manifest.json por defecto..."
    mkdir -p /var/www/html/public
    cat > /var/www/html/public/mix-manifest.json << 'EOF'
{
    "/js/app.js": "/js/app.js",
    "/js/manifest.js": "/js/manifest.js",
    "/css/app.css": "/css/app.css",
    "/css/auth.css": "/css/auth.css",
    "/js/vendor.js": "/js/vendor.js"
}
EOF
fi

# ── Symlink storage ───────────────────────────────────────────────────────────
if [ ! -L /var/www/html/public/storage ]; then
    echo "[setup] Creando symlink storage..."
    php artisan storage:link --force 2>/dev/null || true
fi

# ── Inicializar tablas de tenancy (si no existen) ────────────────────────────
echo "[setup] Verificando tablas del sistema..."
php -r "
    \$pdo = new PDO(
        'mysql:host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT') . ';dbname=' . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD')
    );
    \$tables = \$pdo->query('SHOW TABLES LIKE \"hostnames\"')->fetchAll();
    if (count(\$tables) === 0) {
        echo \"[setup] Creando tablas de tenancy...\\n\";
        \$pdo->exec(file_get_contents('/var/www/html/docker/php/sql/tenancy_schema.sql'));
        // Registrar en migrations para que php artisan migrate no intente crearlas de nuevo
        \$pdo->exec('CREATE TABLE IF NOT EXISTS migrations (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, migration VARCHAR(255) NOT NULL, batch INT NOT NULL) ENGINE=InnoDB');
        \$stmt = \$pdo->prepare('INSERT IGNORE INTO migrations (migration, batch) VALUES (?, ?)');
        \$stmt->execute(['2017_01_01_000003_tenancy_websites', 1]);
        \$stmt->execute(['2017_01_01_000005_tenancy_hostnames', 1]);
        \$stmt->execute(['2018_04_06_000001_tenancy_websites_needs_db_host', 2]);
        echo \"[setup] Tablas de tenancy creadas y registradas.\\n\";
    } else {
        echo \"[setup] Tablas de tenancy ya existen.\\n\";
    }
" 2>&1 || echo "[setup] No se pudieron crear tablas de tenancy (se crearan via migrate)."

# ── Migraciones del sistema ───────────────────────────────────────────────────
echo "[setup] Ejecutando migraciones del sistema..."
php artisan migrate --force 2>&1 || echo "[setup] Migraciones ya ejecutadas o en progreso."

# ── NOTA: El primer tenant (compañia) se crea desde la interfaz admin post-deploy.
# El entrypoint NO crea tenants automaticamente para no interferir con el login
# del sistema (routes/web.php usa el bloque 'if ($hostname)' vs 'else').

# ── Crear admin user si no existe ───────────────────────────────────────────
echo "[setup] Verificando usuario admin..."
php artisan tinker --execute="
    \$email = env('ADMIN_EMAIL', 'admin@midominio.com');
    \$password = env('ADMIN_PASSWORD', '123456');
    \$user = \App\Models\System\User::where('email', \$email)->first();
    if (!\$user) {
        \App\Models\System\User::create([
            'name' => 'Admin',
            'email' => \$email,
            'password' => bcrypt(\$password),
        ]);
        echo \"[setup] Admin user \$email creado.\\n\";
    } else {
        echo \"[setup] Admin user ya existe.\\n\";
    }
" 2>&1 || echo "[setup] No se pudo verificar/crear admin user."

# ── Seed datos del sistema (planes, etc) ────────────────────────────────────
echo "[setup] Verificando seeds del sistema..."
php artisan db:seed --class=DatabaseSeeder --force 2>&1 || echo "[setup] Seeds ya ejecutados."

# ── Optimizaciones de producción ─────────────────────────────────────────────
if [ "${APP_ENV}" = "production" ]; then
    echo "[setup] Aplicando optimizaciones de producción..."
    php artisan config:cache 2>&1 || echo "[setup] config:cache omitido (no crítico)"
    php artisan view:cache 2>/dev/null || echo "[setup] view:cache omitido (no crítico)"
    php artisan route:cache 2>/dev/null || echo "[setup] route:cache omitido (no crítico)"
fi

echo "========================================"
echo "  Inicialización completa – iniciando php-fpm"
echo "========================================"

# Quitar el override de CACHE_DRIVER para que php-fpm herede el valor
# correcto (redis) definido en .env / docker-compose env_file
unset CACHE_DRIVER

exec "$@"
