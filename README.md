# Facturador PRO 6

Sistema de facturación electrónica Perú (SUNAT) — Laravel 10 + Vue 2 + Docker.

## Requisitos del servidor

- Docker y Docker Compose
- Git
- Nginx (para proxy reverso al contenedor interno en puerto 8080)

## Despliegue desde cero

```bash
# 1. Clonar
git clone <repo> facturadorpro6 && cd facturadorpro6

# 2. Configurar .env (OBLIGATORIO)
cp .env.example .env
nano .env
```

### Variables que DEBES cambiar en .env

| Variable | Valor | Como generarlo |
|----------|-------|----------------|
| `APP_KEY` | `base64:...` | `docker run --rm php:8.3-cli php -r "echo 'base64:'.base64_encode(random_bytes(32));"` |
| `APP_URL_BASE` | `midominio.com` | Tu dominio |
| `APP_URL` | `https://midominio.com` | Mismo dominio con HTTPS |
| `DB_PASSWORD` | `una_contraseña_segura` | La que quieras |
| `API_SERVICE_TOKEN` | `token123...` | Token de apiperu.dev o api.migo.pe |

```bash
# 3. Desplegar
chmod +x deploy.sh
./deploy.sh install
```

## Migrar datos desde otro servidor

```bash
# En el servidor ORIGEN: exportar BD
docker exec facturador_mysql mysqldump -uroot -p<TU_PASSWORD> --all-databases > backup.sql

# Copiar backup.sql al nuevo servidor

# En el NUEVO servidor: desplegar primero, luego importar
./deploy.sh install
docker exec -i facturador_mysql mysql -uroot -p<DB_PASSWORD> < backup.sql
```

## Consideraciones importantes

### APP_KEY
- **Critico**: si cambia, los datos encriptados no se pueden leer.
- En produccion se genera una vez y **jamas se cambia**.
- `./deploy.sh install` lo genera automaticamente si esta vacio.

### Base de datos
- Los datos persisten en volumen Docker `mysql8_data`.
- `docker-compose down` NO borra los datos.
- Para borrar datos: `docker volume rm facturadorpro6_mysql8_data`.

### Queue (cola de trabajos)
- Procesa envio de facturas a SUNAT en segundo plano.
- Si se cae, revisar logs: `docker logs facturador_queue --tail 50`.
- Error comun: vendor incompatible con PHP. Solucion: `docker-compose build --no-cache queue`.

### Scheduler (tareas programadas)
- Solo incluido en `docker-compose.prod.yml`.
- Corre `php artisan schedule:run` cada 60 segundos.

### Actualizacion
```bash
./deploy.sh update
# Hace: git pull → rebuild app → reinicia servicios → cache:clear
```

## Comandos utiles

```bash
./deploy.sh install       # Primer despliegue
./deploy.sh update        # Actualizar
./deploy.sh restart       # Reiniciar contenedores
./deploy.sh logs          # Ver logs en vivo
./deploy.sh status        # Estado de contenedores
./deploy.sh artisan <cmd> # Ej: ./deploy.sh artisan migrate
./deploy.sh down          # Detener todo (datos preservados)
```

## Arquitectura

```
Nginx del host (443/80)
  └→ proxy reverso → 127.0.0.1:8080 (Nginx interno Docker)
                       └→ php-fpm (app, puerto 9000)
```

El entrypoint de `app` ejecuta automaticamente al arrancar:
1. Permisos en storage/ y bootstrap/cache/
2. `composer install` si falta vendor/
3. Espera MySQL
4. `storage:link`
5. Crea tablas de tenancy si no existen
6. `php artisan migrate --force`
7. `config:cache` y `view:cache` (solo en produccion)
