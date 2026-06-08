# Facturador PRO 6

Sistema de facturación electrónica Perú (SUNAT) — Laravel 10 + Vue 2 + Docker.

## Requisitos del servidor

- Docker y Docker Compose
- Git
- Nginx (para proxy reverso al contenedor)

## Despliegue rápido

```bash
# 1. Clonar
git clone <repo> facturadorpro6 && cd facturadorpro6

# 2. Configurar entorno
cp .env.example .env
# Editar: APP_KEY, APP_URL_BASE, DB_PASSWORD, API_SERVICE_TOKEN

# 3. Desplegar
chmod +x deploy.sh
./deploy.sh install
```

## Comandos

| Comando | Descripción |
|---------|-------------|
| `./deploy.sh install` | Primer despliegue completo |
| `./deploy.sh update` | git pull + rebuild + reiniciar |
| `./deploy.sh restart` | Solo reiniciar contenedores |
| `./deploy.sh logs` | Ver logs en tiempo real |
| `./deploy.sh status` | Estado de contenedores |
| `./deploy.sh artisan <cmd>` | Ejecutar comando Artisan |
| `./deploy.sh down` | Detener contenedores (datos conservados) |

## Variables de entorno (.env)

Variables que **debes** configurar antes del deploy:

| Variable | Descripción |
|----------|-------------|
| `APP_KEY` | Generar con: `php artisan key:generate --show` |
| `APP_URL_BASE` | Tu dominio (ej: midominio.com) |
| `APP_URL` | `https://midominio.com` |
| `DB_PASSWORD` | Contraseña segura para MySQL |
| `API_SERVICE_TOKEN` | Token de apiperu.dev o api.migo.pe |

## Servicios Docker

- **app** — PHP 8.3-FPM con extensiones (gd, zip, intl, soap, redis, etc.)
- **nginx** — Servidor web interno (puerto 8080)
- **mysql** — MySQL 8.0
- **redis** — Cache y sesiones
- **queue** — Worker de colas
- **scheduler** — Tareas programadas (cada 60s)

## Arquitectura

```
Nginx del host (puerto 443/80)
  └→ proxy reverso → 127.0.0.1:8080 (Nginx interno Docker)
                       └→ php-fpm (app)
```

El entrypoint del contenedor `app` ejecuta automáticamente: permisos, migraciones, `config:cache` y `view:cache`.
