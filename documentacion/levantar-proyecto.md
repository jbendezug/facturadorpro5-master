# Levantar Facturador Pro 6 con Docker

## Requisitos

- Docker Engine 24+
- Docker Compose 1.29+ o docker compose v2
- Git

## Pasos

### 1. Clonar y entrar al proyecto

```bash
git clone https://github.com/jbendezug/facturadorpro5-master.git
cd facturadorpro5-master
```

### 2. Crear .env

```bash
cp .env.production .env
# Editar .env con tus datos
nano .env
```

Variables obligatorias a cambiar:
```
APP_URL_BASE=midominio.com         # tu dominio
APP_URL=https://midominio.com
DB_PASSWORD=contraseña_segura       # contraseña de MySQL
API_SERVICE_TOKEN=tu_token          # token de apiperu.dev
```

Luego generar APP_KEY:
```bash
php artisan key:generate
```

### 3. Construir imágenes Docker

```bash
docker-compose build --no-cache app
```

Esto toma ~10-20 minutos la primera vez (compila extensiones PHP).

### 4. Iniciar servicios

```bash
# Opcion A - Iniciar todo
docker-compose up -d mysql redis app nginx

# Opcion B - Si docker-compose falla (bug v1), iniciar manual:
docker network create facturador_net 2>/dev/null

docker run -d --name facturador_mysql \
  --network facturador_net \
  -e MYSQL_ROOT_PASSWORD=contraseña_segura \
  -e MYSQL_DATABASE=tenancy \
  -p 3307:3306 \
  mysql:8.0 \
  --default-authentication-plugin=mysql_native_password

docker run -d --name facturador_redis \
  --network facturador_net \
  -p 6380:6379 \
  redis:7-alpine

docker run -d --name facturador_app \
  --network facturador_net \
  --network-alias app \
  -v $(pwd):/var/www/html \
  -e APP_ENV=production \
  -e APP_KEY=... \
  -e DB_HOST=mysql \
  -e DB_PASSWORD=contraseña_segura \
  facturadorpro5-master_app

docker run -d --name facturador_nginx \
  -p 80:80 \
  --network facturador_net \
  -v $(pwd):/var/www/html \
  -v $(pwd)/docker/nginx/default.conf:/etc/nginx/conf.d/default.conf \
  nginx:1.25-alpine
```

### 5. Verificar

```bash
curl -s http://localhost/login -o /dev/null -w "HTTP %{http_code}\n"
# Debe responder 200
```

### 6. Migraciones

```bash
docker exec facturador_app php artisan migrate --force
docker exec facturador_app php artisan tenancy:migrate --force
docker exec facturador_app php artisan db:seed --force
```

### 7. Compilar frontend (si aplica)

```bash
docker exec facturador_app npm run production
```

## Puertos por defecto

| Servicio | Puerto | Archivo de config |
|----------|--------|------------------|
| Nginx (web) | `80` | `docker-compose.yml:43` |
| MySQL | `3307` | `docker-compose.yml:67` |
| Redis | `6380` | `docker-compose.yml:87` |
| PHP-FPM | `9000` | Interno (no expuesto) |

Para cambiar puertos, editar `docker-compose.yml` y reiniciar.

## Comandos utiles

```bash
# Ver logs
docker logs facturador_app --tail 50

# Entrar al contenedor
docker exec -it facturador_app bash

# Recompilar frontend
docker exec facturador_app npm run production

# Ver base de datos
docker exec -it facturador_mysql mysql -uroot -pcontraseña_segura tenancy

# Limpiar cache de Laravel
docker exec facturador_app php artisan optimize:clear

# Cache de config para produccion
docker exec facturador_app php artisan config:cache
docker exec facturador_app php artisan route:cache
docker exec facturador_app php artisan view:cache
```

## Troubleshooting

**502 Bad Gateway**: Nginx no encuentra PHP-FPM
```bash
docker ps | grep facturador_app   # debe estar "Up"
docker logs facturador_app --tail 20
```

**500 Internal Server Error**: Error en PHP/Laravel
```bash
docker exec facturador_app php artisan optimize:clear
```

**MySQL no conecta**: Esperar a que mysql inicie (30-60s primera vez)
```bash
docker logs facturador_mysql --tail 10
```

**app.js no aparece** (Vue en blanco):
```bash
docker exec facturador_app npm run production
```
