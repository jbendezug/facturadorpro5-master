# Levantar Facturador Pro 6

## Comandos rápidos

```bash
cd /home/jean/Documentos/desarrollos/Facturador-Pro6/facturadorpro5-master
```

### 1. Iniciar servicios

```bash
docker-compose up -d app nginx
```

### 2. Si el app container falla (bug docker-compose v1)

```bash
docker run -d --name facturador_app \
  --network facturadorpro5-master_facturador_net \
  --network-alias app \
  -v $(pwd):/var/www/html \
  -e APP_ENV=local \
  -e APP_KEY=base64:/sI32TU56qHYuwCzFTMe5HtPSMsftEsXOeReAdTw4bE= \
  -e DB_HOST=mysql -e DB_PORT=3306 -e DB_DATABASE=tenancy \
  -e DB_USERNAME=root -e DB_PASSWORD=secret \
  -e REDIS_HOST=redis -e REDIS_PORT=6379 \
  facturadorpro5-master_app
```

### 3. Si nginx no arranca

```bash
docker run -d --name facturador_nginx \
  -p 8080:80 \
  --network facturadorpro5-master_facturador_net \
  -v $(pwd):/var/www/html \
  -v $(pwd)/docker/nginx/default.conf:/etc/nginx/conf.d/default.conf \
  nginx:1.25-alpine
```

### 4. Verificar

```bash
curl -s http://localhost:8080/login -o /dev/null -w "HTTP %{http_code}\n"
```

### 5. Reconstruir imagen app (tras cambios)

```bash
docker-compose build --no-cache app
```

## URLs

| URL | Descripción |
|-----|-------------|
| `http://localhost:8080/login` | Admin |
| `http://injuserv.localhost:8080/login` | Tenant |

## Credenciales

| Rol | Email | Password |
|-----|-------|----------|
| Admin | `admin@gmail.com` | `password` |
| Tenant | `injuserv@admin.com` | `password` |

## Troubleshooting

**502 Bad Gateway**: El nginx no encuentra el app container. Verificar que `facturador_app` esté corriendo:

```bash
docker ps --filter "name=facturador" --format "table {{.Names}}\t{{.Status}}"
```

**500 Internal Server Error**: Revisar logs:

```bash
docker logs facturador_app --tail 20
```

**Puerto 8080 ocupado**:

```bash
docker ps --filter "publish=8080"
```
