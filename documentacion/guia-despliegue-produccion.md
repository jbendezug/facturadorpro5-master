# Guía de Despliegue en Producción - Facturador Pro 6

## Stack Actual (Post-Migración)

| Componente | Versión | Detalle |
|-----------|---------|---------|
| PHP | **8.3** | Docker image `php:8.3-fpm` |
| Laravel | **10.50.2** | Framework |
| MySQL | **8.0** | Base de datos |
| Redis | **7.x** | Cache, sesiones, colas |
| Nginx | **1.25** | Servidor web |
| Node.js | **20.x** | Compilación frontend |
| Vue | **2.6.14** | Frontend |
| Element UI | **2.15.14** | UI framework |
| Composer | **2.10+** | Dependencias PHP |

## Requisitos del Servidor

| Requisito | Mínimo | Recomendado |
|-----------|--------|-------------|
| RAM | 4 GB | 8 GB |
| CPU | 2 cores | 4 cores |
| Disco | 20 GB | 50 GB SSD |
| Docker | 24+ | última versión |
| Docker Compose | 1.29+ o docker compose v2 | última versión |
| SO | Ubuntu 22.04+ / Debian 12+ | - |

## Archivos de Configuración Clave

| Archivo | Propósito | ¿Requiere cambios por servidor? |
|---------|-----------|-------------------------------|
| `.env` | Variables de entorno del sistema | **SÍ** - dominio, BD, tokens |
| `docker-compose.yml` | Servicios Docker | Solo si cambian puertos |
| `docker/nginx/default.conf` | Configuración Nginx | Rara vez |
| `docker/php/Dockerfile` | Imagen PHP | No (ya configurado) |
| `docker/php/entrypoint.sh` | Inicialización del contenedor | No (ya configurado) |
| `docker/php/sql/tenancy_schema.sql` | Schema inicial de tenancy | No |

## Pasos de Despliegue

### 1. Clonar el repositorio

```bash
git clone https://github.com/jbendezug/facturadorpro5-master.git
cd facturadorpro5-master
```

### 2. Configurar .env

```bash
cp .env.production .env
nano .env
```

Variables **obligatorias** a cambiar:

```
APP_KEY=                          # Generar con: php artisan key:generate --show
APP_URL_BASE=midominio.com        # Tu dominio
APP_URL=https://midominio.com     # Misma URL con https
DB_PASSWORD=contraseña_segura     # Contraseña de MySQL
API_SERVICE_TOKEN=tu_token        # Token de apiperu.dev o api.migo.pe
```

Variables recomendadas para producción:

```
APP_DEBUG=false
FORCE_HTTPS=true
SESSION_DRIVER=redis
CACHE_DRIVER=redis
QUEUE_CONNECTION=redis
```

> ⚠️ La contraseña de MySQL no debe contener caracteres que el shell pueda interpretar (`$`, `\`, `"`, `` ` ``). Si los tiene, escápala o cámbiala.

### 3. Generar APP_KEY

```bash
# Con PHP (si está instalado)
php artisan key:generate

# Con Docker (si no hay PHP en el host)
docker run --rm --entrypoint php php:8.3-fpm \
  -r "echo 'base64:'.base64_encode(random_bytes(32));"
```

### 4. Construir imágenes Docker

```bash
# Primera vez: tarda 10-30 minutos (descarga PHP 8.3 y compila extensiones)
docker-compose build --no-cache app

# En builds posteriores (solo si cambia código):
docker-compose build app
```

### 5. Iniciar servicios

```bash
docker-compose up -d mysql redis app nginx
```

### 6. Verificar que los contenedores estén saludables

```bash
docker ps --filter "name=facturador" --format "table {{.Names}}\t{{.Status}}"

# Debe mostrar todos como "Up" o "Healthy"
# facturador_mysql   Up (healthy)
# facturador_redis   Up (healthy)
# facturador_app     Up
# facturador_nginx   Up
```

### 7. Ejecutar migraciones

```bash
# Migraciones del sistema (crea tablas: websites, hostnames, users, etc.)
docker exec facturador_app php artisan migrate --force

# Migraciones de tenants (para bases de datos de clientes)
docker exec facturador_app php artisan tenancy:migrate --force

# Seeders (crea usuario admin, catálogos, configuraciones)
docker exec facturador_app php artisan db:seed --force
```

### 8. Crear website y hostname inicial

```bash
docker exec facturador_app php artisan tinker --execute='
$website = \Hyn\Tenancy\Models\Website::create(["uuid" => "default"]);
\Hyn\Tenancy\Models\Hostname::create([
    "fqdn" => env("APP_URL_BASE"),
    "website_id" => $website->id
]);
echo "Website y hostname creados.\n";
'
```

> Reemplaza `env("APP_URL_BASE")` por tu dominio si el comando no lo resuelve.

### 9. Compilar frontend

```bash
docker exec facturador_app npm run production
```

Esto genera los archivos:
- `public/js/app.js` (258KB) + chunks lazy loading
- `public/js/vendor.js` (2.5MB)
- `public/css/app.css` (1.7MB con Element UI)
- `public/mix-manifest.json`

### 10. Optimizar Laravel para producción

```bash
docker exec facturador_app php artisan config:cache
docker exec facturador_app php artisan route:cache
docker exec facturador_app php artisan view:cache
docker exec facturador_app php artisan storage:link
```

### 11. Verificar funcionamiento

```bash
curl -s https://midominio.com/login -o /dev/null -w "HTTP %{http_code}\n"
# Debe responder 200

curl -s https://midominio.com/api/login -o /dev/null -w "HTTP %{http_code}\n"
# Debe responder 200
```

## Puertos y Acceso

| Servicio | Puerto Externo | Puerto Interno | ¿Accesible desde fuera? |
|----------|---------------|---------------|----------------------|
| Nginx (web) | `80` / `443` | `80` | **SÍ** (por el reverse proxy) |
| MySQL | `3307` | `3306` | No recomendado |
| Redis | `6380` | `6379` | No recomendado |
| PHP-FPM | - | `9000` | No |

Los puertos se cambian en `docker-compose.yml`:

```yaml
ports:
  - "8080:80"    # izquierda: puerto externo, derecha: interno
```

## Usuarios por Defecto

| Rol | Email | Password |
|-----|-------|----------|
| Admin sistema | `admin@gmail.com` | `password` |
| Admin tenant | `admin@empresa.com` | `password` |

> ⚠️ Cambiar estas contraseñas después del primer ingreso.

## Pipeline de Compilación Frontend

El build de frontend sigue este orden:

```
npm run production
  ├── mix --production   → genera JS (app.js, vendor.js, manifest.js, chunks)
  └── node build-css.js  → genera CSS completo con Dart Sass (Element UI + Bootstrap)
```

Los chunks de JS se cargan bajo demanda (lazy loading). El `app.js` pasó de 7MB a 258KB.

## Cache y Performance

| Tipo | Driver | TTL | Beneficio |
|------|--------|-----|-----------|
| Cache aplicación | Redis | variable | Tablas maestras cacheadas 30min |
| Cache sesiones | Redis | 120 min | Sesiones rápidas y compartidas |
| Colas (queues) | Redis | - | Procesamiento asíncrono |
| Consultas RUC/DNI | Redis | 24h | Evita llamadas HTTP repetitivas |
| Vistas Blade | File | - | Compiladas, cache automático |

Para limpiar cache en producción:

```bash
docker exec facturador_app php artisan optimize:clear
```

## Logs y Monitoreo

```bash
# Logs del contenedor app
docker logs facturador_app --tail 50

# Logs de Laravel
docker exec facturador_app cat storage/logs/laravel-$(date +%Y-%m-%d).log

# Logs de Nginx
docker exec facturador_nginx cat /var/log/nginx/access.log | tail -20

# Redis info (uso de memoria, hits)
docker exec facturador_redis redis-cli INFO stats | grep -E "keyspace_hits|keyspace_misses"
```

## Troubleshooting Común

### El contenedor app se reinicia en bucle

```bash
# Ver logs
docker logs facturador_app --tail 50

# Causa más común: falta correr migrate
docker exec facturador_app php artisan migrate --force
```

Error típico:
```
SQLSTATE[42S02]: Base table or view not found: 1146 Table 'tenancy.hostnames' doesn't exist
```

Solución:
```bash
docker exec facturador_app php artisan migrate --force
```

### 404 en todas las rutas

Causa: `APP_URL_BASE` en `.env` no coincide con el dominio de acceso.

Solución:
```bash
# Verificar
grep APP_URL_BASE .env

# Debe coincidir con el dominio real
# Si accedes por midominio.com → APP_URL_BASE=midominio.com
```

### 502 Bad Gateway

Nginx no puede conectar con PHP-FPM:

```bash
docker ps | grep facturador_app
# Si no está "Up", revisar logs:
docker logs facturador_app --tail 20
```

### Error: "Class 'Faker\Factory' not found"

El entrypoint instaló dependencias con dev. Solución:

```bash
docker exec facturador_app composer install --no-dev --optimize-autoloader
```

### Error: Paquetes requieren PHP >=8.2 pero el contenedor tiene 8.1

```bash
# Verificar PHP en el contenedor
docker exec facturador_app php -v | head -1

# Si no es 8.3+, reconstruir la imagen
docker-compose build --no-cache app
```

## Comandos de Mantenimiento

```bash
# Restaurar permisos
docker exec facturador_app chmod -R 775 storage bootstrap/cache

# Backup de base de datos
docker exec facturador_mysql mysqldump -uroot -p$DB_PASSWORD --all-databases > backup.sql

# Limpiar cache de Redis
docker exec facturador_redis redis-cli FLUSHDB

# Recompilar frontend
docker exec facturador_app npm run production

# Actualizar código
git pull origin main
docker-compose build app
docker-compose up -d app nginx
```

## Arquitectura de Red Docker

```
Internet
    │
    ▼
Nginx (facturador_nginx) :80
    │
    ▼
PHP-FPM (facturador_app) :9000
    │
    ├──── MySQL (facturador_mysql) :3306
    │
    └──── Redis (facturador_redis) :6379
                ├── Cache (db:1)
                ├── Session (db:2)
                └── Queue (db:3)
```

## Resumen de Archivos Clave del Proyecto

```
facturadorpro5-master/
├── .env                         # Configuración del entorno
├── composer.json                # Dependencias PHP
├── package.json                 # Dependencias frontend
├── webpack.mix.js               # Build frontend
├── build-css.js                 # Compilación CSS con Dart Sass
├── docker-compose.yml           # Servicios Docker
├── docker/
│   ├── nginx/default.conf       # Configuración Nginx
│   └── php/
│       ├── Dockerfile           # Imagen PHP 8.3-fpm
│       ├── entrypoint.sh        # Entrypoint del contenedor
│       └── sql/tenancy_schema.sql  # Schema inicial tenancy
├── app/
│   └── CoreFacturalo/           # Motor de facturación SUNAT
├── modules/                     # 28 módulos funcionales
├── resources/
│   ├── js/                      # Vue.js frontend
│   └── sass/                    # Estilos SCSS
└── public/
    ├── js/                      # JS compilado (app.js, vendor.js, chunks)
    └── css/                     # CSS compilado (app.css)
```
