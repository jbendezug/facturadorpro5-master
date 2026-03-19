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
echo "[setup] Ajustando permisos en storage/ y bootstrap/cache/ ..."
chown -R www-data:www-data \
    /var/www/html/storage \
    /var/www/html/bootstrap/cache 2>/dev/null || true
chmod -R 775 \
    /var/www/html/storage \
    /var/www/html/bootstrap/cache 2>/dev/null || true

# ── Instalar dependencias si vendor/ no existe ──────────────────────────────
if [ ! -f /var/www/html/vendor/autoload.php ]; then
    echo "[setup] vendor/ no encontrado – ejecutando composer install ..."
    composer install \
        --no-interaction \
        --no-dev \
        --optimize-autoloader \
        --prefer-dist
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

# ── Migraciones del sistema ───────────────────────────────────────────────────
echo "[setup] Ejecutando migraciones del sistema..."
php artisan migrate --force

# ── Optimizaciones de producción ─────────────────────────────────────────────
if [ "${APP_ENV}" = "production" ]; then
    echo "[setup] Aplicando optimizaciones de producción..."
    php artisan config:cache
    php artisan view:cache
fi

echo "========================================"
echo "  Inicialización completa – iniciando php-fpm"
echo "========================================"

exec "$@"
