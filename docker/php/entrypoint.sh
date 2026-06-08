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

# ── Crear tenant por defecto si no existe ninguno ──────────────────────────
echo "[setup] Verificando hostnames existentes..."
php -r "
    \$pdo = new PDO(
        'mysql:host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT') . ';dbname=' . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD')
    );
    \$count = \$pdo->query('SELECT COUNT(*) FROM hostnames')->fetchColumn();
    if (\$count == 0) {
        echo \"[setup] Creando tenant por defecto...\\n\";
        \$fqdn = getenv('APP_URL_BASE') ?: 'localhost';
        \$uuid = substr(bin2hex(random_bytes(16)), 0, 32);
        // Insert website
        \$pdo->prepare('INSERT INTO websites (uuid, created_at, updated_at) VALUES (?, NOW(), NOW())')->execute([\$uuid]);
        \$websiteId = \$pdo->lastInsertId();
        // Insert hostname
        \$pdo->prepare('INSERT INTO hostnames (fqdn, website_id, created_at, updated_at) VALUES (?, ?, NOW(), NOW())')->execute([\$fqdn, \$websiteId]);
        // Create tenant database
        \$pdo->exec('CREATE DATABASE IF NOT EXISTS \`' . \$uuid . '\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci');
        echo \"[setup] Tenant \$fqdn creado (BD: \$uuid).\\n\";
    } else {
        echo \"[setup] Ya existen \$count hostname(s).\\n\";
    }
" 2>&1 || echo "[setup] No se pudo crear tenant por defecto."

# ── Crear usuario MySQL del tenant si no existe ──────────────────────────────
echo "[setup] Verificando usuarios MySQL de tenants..."
php -r "
    try {
        \$pdoSystem = new PDO(
            'mysql:host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT'),
            getenv('DB_USERNAME'),
            getenv('DB_PASSWORD')
        );
        \$websites = \$pdoSystem->query('SELECT id, uuid, created_at FROM ' . getenv('DB_DATABASE') . '.websites')->fetchAll(PDO::FETCH_OBJ);
        foreach (\$websites as \$w) {
            // Check if user exists
            \$users = \$pdoSystem->query(\"SELECT user FROM mysql.user WHERE user = '\$w->uuid'\")->fetchAll();
            if (count(\$users) == 0) {
                // Calculate password using same algorithm as hyn DefaultPasswordGenerator
                \$key = getenv('APP_KEY') ?: 'base64:unknown';
                \$password = md5(\"{$w->id}.\$w->uuid.\$w->created_at.\$key\");
                // Create user and grant
                \$pdoSystem->exec(\"CREATE USER IF NOT EXISTS '\$w->uuid'@'%' IDENTIFIED WITH mysql_native_password BY '\$password'\");
                \$pdoSystem->exec(\"GRANT ALL PRIVILEGES ON \`\$w->uuid\`.* TO '\$w->uuid'@'%'\");
                \$pdoSystem->exec('FLUSH PRIVILEGES');
                echo \"[setup] Usuario MySQL \$w->uuid creado.\\n\";
            }
        }
    } catch (Exception \$e) {
        echo \"[setup] Error creando usuarios: \" . \$e->getMessage() . \"\\n\";
    }
" 2>&1 || echo "[setup] No se pudieron crear usuarios MySQL."

# ── Migraciones de tenants ──────────────────────────────────────────────────
echo "[setup] Ejecutando migraciones de tenants..."
php artisan tenancy:migrate --force 2>&1 || echo "[setup] Migraciones de tenants ya ejecutadas."

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
