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

### Primer deploy (BD limpia)
El entrypoint automatiza todo el proceso, pero hay que tener en cuenta:

1. `vendor/` debe existir. Si el clone es fresco, el entrypoint ejecuta `composer install --no-scripts` y luego `dump-autoload`. Si el lockfile y composer.json no coinciden (por cambios manuales), fallara. **Siempre hacer `composer update` local y pushear el lockfile antes de deployar.**
2. Las tablas de tenancy (`websites`, `hostnames`) se crean via SQL antes de que Laravel bootstrapee (el RouteServiceProvider las necesita). Luego se registran como migradas para que `migrate` no intente crearlas de nuevo.
3. `php artisan migrate --force` corre todas las migrations del sistema (usuarios, configuraciones, planes, etc.).
4. Si alguna migracion falla porque la tabla ya existe, el entrypoint continua con `||` y el container arranca igual. Revisar logs con `docker logs facturador_app`.

### FORCE_HTTPS
- `.env.example` trae `FORCE_HTTPS=false`. Pon `true` solo si tu Nginx externo ya termina SSL.
- Si activas sin SSL configurado, el navegador hara bucle de redireccion.

### Queue (cola de trabajos)
- Procesa envio de facturas a SUNAT en segundo plano.
- Si se cae: `docker logs facturador_queue --tail 50`.
- Error comun: vendor incompatible con PHP (imagen vieja). Solucion: `docker-compose build --no-cache queue` o taguear la imagen de app: `docker tag facturadorpro6_app queue`.

### Scheduler (tareas programadas)
- Solo incluido en `docker-compose.prod.yml`.
- Corre `php artisan schedule:run` cada 60 segundos.

### Actualizacion
```bash
./deploy.sh update
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
