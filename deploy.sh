#!/bin/bash
# =============================================================================
# deploy.sh  –  FacturadorPro5  –  Script de despliegue en Ubuntu Server
# =============================================================================
# Primer despliegue:
#   chmod +x deploy.sh
#   ./deploy.sh install
#
# Actualizar (git pull + rebuild + migrate):
#   ./deploy.sh update
#
# Solo reiniciar contenedores:
#   ./deploy.sh restart
# =============================================================================
set -euo pipefail

COMPOSE_FILE="docker-compose.prod.yml"
APP_CONTAINER="facturador_app"

# ── Colores ───────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
info()    { echo -e "${GREEN}[INFO]${NC}  $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

# ── Verificar dependencias ────────────────────────────────────────────────────
command -v docker  >/dev/null 2>&1 || error "Docker no está instalado."
command -v git     >/dev/null 2>&1 || error "Git no está instalado."

# ── Subcomandos ───────────────────────────────────────────────────────────────

cmd_install() {
    info "=== INSTALACIÓN INICIAL ==="

    [ ! -f ".env" ] && {
        warn ".env no encontrado. Copiando desde .env.prod.example ..."
        cp .env.prod.example .env
        warn "EDITA el archivo .env antes de continuar (DB_PASSWORD, APP_KEY, dominio)."
        warn "Luego vuelve a ejecutar: ./deploy.sh install"
        exit 0
    }

    # Generar APP_KEY si está vacío
    if grep -q "^APP_KEY=$" .env; then
        info "Generando APP_KEY ..."
        KEY=$(docker run --rm php:7.4-cli php -r "echo 'base64:'.base64_encode(random_bytes(32));")
        sed -i "s|^APP_KEY=.*|APP_KEY=${KEY}|" .env
        info "APP_KEY generada."
    fi

    info "Construyendo imágenes Docker ..."
    docker compose -f "$COMPOSE_FILE" build --no-cache

    info "Iniciando servicios ..."
    docker compose -f "$COMPOSE_FILE" up -d

    info "Esperando a que el contenedor app esté listo ..."
    sleep 15

    info "=== Instalación finalizada ==="
    docker compose -f "$COMPOSE_FILE" ps
}

cmd_update() {
    info "=== ACTUALIZACIÓN ==="

    info "[1/4] Pull del repositorio ..."
    git pull

    info "[2/4] Reconstruyendo imagen ..."
    docker compose -f "$COMPOSE_FILE" build app

    info "[3/4] Reiniciando servicios ..."
    docker compose -f "$COMPOSE_FILE" up -d --no-deps app queue scheduler

    info "[4/4] Post-despliegue (caché, migraciones ya corren en entrypoint) ..."
    sleep 8
    docker compose -f "$COMPOSE_FILE" exec "$APP_CONTAINER" php artisan cache:clear
    docker compose -f "$COMPOSE_FILE" exec "$APP_CONTAINER" php artisan config:cache
    docker compose -f "$COMPOSE_FILE" exec "$APP_CONTAINER" php artisan view:cache

    info "=== Actualización finalizada ==="
}

cmd_restart() {
    info "Reiniciando contenedores ..."
    docker compose -f "$COMPOSE_FILE" restart
    docker compose -f "$COMPOSE_FILE" ps
}

cmd_logs() {
    docker compose -f "$COMPOSE_FILE" logs --tail=100 -f
}

cmd_status() {
    docker compose -f "$COMPOSE_FILE" ps
    echo ""
    echo "── Healthcheck MySQL ──"
    docker inspect --format='{{.State.Health.Status}}' facturador_mysql 2>/dev/null || true
    echo "── Healthcheck Redis ──"
    docker inspect --format='{{.State.Health.Status}}' facturador_redis 2>/dev/null || true
}

cmd_artisan() {
    docker compose -f "$COMPOSE_FILE" exec "$APP_CONTAINER" php artisan "${@:2}"
}

cmd_down() {
    warn "Deteniendo contenedores (datos en volúmenes se conservan) ..."
    docker compose -f "$COMPOSE_FILE" down
}

# ── Dispatch ─────────────────────────────────────────────────────────────────
case "${1:-help}" in
    install) cmd_install ;;
    update)  cmd_update ;;
    restart) cmd_restart ;;
    logs)    cmd_logs ;;
    status)  cmd_status ;;
    artisan) cmd_artisan "$@" ;;
    down)    cmd_down ;;
    *)
        echo "Uso: $0 {install|update|restart|logs|status|artisan <cmd>|down}"
        echo ""
        echo "  install  – Primer despliegue completo"
        echo "  update   – git pull + rebuild + reiniciar"
        echo "  restart  – Solo reiniciar contenedores"
        echo "  logs     – Ver logs en tiempo real (Ctrl+C para salir)"
        echo "  status   – Estado de los contenedores"
        echo "  artisan  – Ejecutar un comando artisan. Ej: ./deploy.sh artisan migrate"
        echo "  down     – Detener todos los contenedores"
        ;;
esac
