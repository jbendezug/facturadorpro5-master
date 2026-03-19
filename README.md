# ** Facturador PRO 5 **

---

## 🚀 Despliegue en Servidor Ubuntu con Docker (Configuración actualizada)

### Estructura de archivos Docker incluida

```
facturadorpro5/
├── docker-compose.yml          ← Desarrollo local (PC)
├── docker-compose.prod.yml     ← Producción (servidor Ubuntu)
├── .env.prod.example           ← Template de variables para producción
├── deploy.sh                   ← Script de despliegue automatizado
├── .dockerignore
└── docker/
    ├── php/
    │   ├── Dockerfile
    │   ├── entrypoint.sh       ← Arranque: permisos, migraciones, caché
    │   └── local.ini
    ├── nginx/
    │   ├── default.conf        ← Nginx interno del contenedor
    │   └── nginx-proxy.conf    ← Config para el Nginx del HOST (reverse proxy)
    └── mysql/
        └── my.cnf
```

---

### Caso: Proyecto corriendo en local (docker-compose) → subir al servidor

#### 1. Exportar la base de datos desde tu PC local

```bash
# Desde tu PC local — exportar la BD del contenedor MySQL
docker exec facturador_mysql mysqldump -uroot -p<TU_PASSWORD> --all-databases > backup_local.sql

# Copiar el backup al servidor
scp backup_local.sql usuario@IP_SERVIDOR:/opt/facturadorpro5/
```

#### 2. Preparar el servidor Ubuntu

```bash
# Conectarte al servidor
ssh usuario@IP_SERVIDOR

# Instalar Docker y Docker Compose (si no están instalados)
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
newgrp docker

# Clonar o copiar el proyecto
cd /opt
git clone <url-del-repo> facturadorpro5
cd facturadorpro5
```

#### 3. Configurar variables de entorno

```bash
# Copiar el template de producción
cp .env.prod.example .env
nano .env

# Valores MÍNIMOS que debes cambiar:
#   APP_KEY=              ← genera con: php artisan key:generate --show
#   APP_URL=              ← https://tudominio.com
#   APP_URL_BASE=         ← tudominio.com
#   DB_PASSWORD=          ← contraseña segura
#   API_SERVICE_URL=      ← https://api.migo.pe
#   API_SERVICE_TOKEN=    ← tu token de api.migo.pe
```

#### 4. Primer despliegue

```bash
chmod +x deploy.sh
./deploy.sh install
```

El script automáticamente:
- Construye la imagen PHP con todas las extensiones
- Levanta MySQL, Redis, Nginx, Queue worker y Scheduler
- Ejecuta las migraciones de Laravel
- Aplica `config:cache` y `view:cache`

#### 5. Importar la base de datos del entorno local

```bash
# Esperar a que MySQL esté listo (30-60 seg tras el install)
# Luego importar el backup
docker exec -i facturador_mysql mysql -uroot -p<DB_PASSWORD> < backup_local.sql
```

#### 6. Configurar el Nginx del HOST (reverse proxy)

Tu servidor ya tiene Nginx instalado. Solo agrega el sitio:

```bash
# Copiar la configuración lista
sudo cp docker/nginx/nginx-proxy.conf /etc/nginx/sites-available/facturadorpro5

# Editar el archivo y reemplazar "tudominio.com" con tu dominio real
sudo nano /etc/nginx/sites-available/facturadorpro5

# Activar y recargar
sudo ln -s /etc/nginx/sites-available/facturadorpro5 /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

#### 7. SSL con Let's Encrypt (recomendado)

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d tudominio.com -d www.tudominio.com
```

---

### Comandos cotidianos con deploy.sh

```bash
./deploy.sh status           # Ver estado de todos los contenedores
./deploy.sh logs             # Ver logs en tiempo real (Ctrl+C para salir)
./deploy.sh update           # git pull + rebuild + reiniciar (sin bajar la BD)
./deploy.sh restart          # Solo reiniciar contenedores
./deploy.sh artisan migrate  # Correr cualquier comando artisan
./deploy.sh down             # Detener todo (los datos se conservan en volúmenes)
```

### Diferencias entre entornos

| Característica | Local (`docker-compose.yml`) | Servidor (`docker-compose.prod.yml`) |
|---|---|---|
| `APP_ENV` | local | production |
| `APP_DEBUG` | true | false |
| Puerto MySQL | 3307 (accesible desde host) | solo interno |
| Puerto Redis | 6380 (accesible desde host) | solo interno |
| Nginx | 0.0.0.0:8080 | 127.0.0.1:8080 (solo localhost) |
| Scheduler | no incluido | incluido como servicio |
| Caché | no aplicada | config:cache + view:cache |

---

## Manuales de Instalación

[Google Cloud - Ubuntu 18.04](https://www.youtube.com/watch?v=DChb3DQDxlw "Clic")
<br>
[Windows - Linux](https://drive.google.com/file/d/1GowS3z9dbrN6htRcWybJG-X68PZbfdO2/view?usp=sharing "Clic")
<br>
[Docker - Linux](https://drive.google.com/file/d/1WrDb-zBLUJtRtgz9NhlP3dvWoXU1KCRt/view?usp=sharing "Clic")
<br>
[Docker - Linux - SSL](https://drive.google.com/file/d/1sOFAZWh9i4YI6_ngxRjSAtrL2MJlqu_x/view?usp=sharing "Clic")
<br>
[Valet - Linux](https://drive.google.com/file/d/1G-FPQvzF5X2d0wPlYNenl8IQBQf1Canw/view?usp=sharing "Clic")
<br>
[Linux - gestión externa de SSL](https://drive.google.com/file/d/1-cFdZ1CFeERbaHP_WN4hZV9qZnLyPz6h/view?usp=sharing "Clic")


### Scripts de instalación con Docker

Linux - Ubuntu 18 - Docker - SSL opcional<br>
[Guia](https://drive.google.com/file/d/1c0D3nU3E2TfDKG2GDUWzmqbeOjYOxfkg/view?usp=sharing "clic") <br>
[Script](https://drive.google.com/file/d/14xecD-9alkz9uYKCH0DHNHR3P2xpMVX0/view?usp=sharing "clic" )

### Manuales de actualización

* Docker - Comandos manuales

[Con Docker](https://drive.google.com/file/d/1xS2EPIVDpfV0tkcuO14I1DgjSpUxo7XF/view?usp=sharing "Clic")
<br>


### Manuales de actualización de SSL gratuito

* Docker

[SSL](https://drive.google.com/file/d/1zixiayWttXdk5Obb2xmYKRgfGCiUi9or/view?usp=sharing "Clic")


### Manuales de Usuario

[YouTube Tutorial 1 ](https://youtu.be/a-tH1iYFuYM "Clic")[- YouTube Tutorial 2](https://youtu.be/8oAD2NJdNl8 "Clic")<br>
[YouTube Dar de alta en Sunat](https://youtu.be/tic_c2SVKdM "Clic")<br>
[Manual de usuario](https://drive.google.com/file/d/1MRYuJczgGjVsrKMGDjnWlELmVeQ8NZt6/view?usp=sharing "Clic")<br>
[Manual de Tareas Programadas](https://drive.google.com/file/d/1Z35qKjdoY5lMyXhtcUu6D3fjRAw0Je3U/view?usp=sharing "Clic")<br>
[Manual de Cambio de Entorno](https://drive.google.com/file/d/1gmWB3LXZ2XP57tJWQSuhEjXlHcTPA03V/view?usp=sharing "Clic")<br>
[Manual de Pruebas](https://drive.google.com/file/d/1qBwn8oebHXMFIW9_ZNg9mMMbnslE5TFD/view?usp=sharing "Clic")

## API

[Documentación API REST PRO4](https://docs.google.com/document/d/1e3-tMzQfG1sKQDl1zFlWicpvHVy7LwGP/edit?usp=sharing&ouid=115578596704941457505&rtpof=true&sd=true "Clic")<br>
[Descargar colección para Postman](https://drive.google.com/file/d/1eTAJseghS4NW-lc2UnZnxZhfG-eMycCl/view?usp=sharing "Clic")<br>
[Documentación - json con respuestas](https://drive.google.com/file/d/14G4RcT9yTz83WdrBTO0dmGPjwWGMDdCe/view?usp=sharing "Clic")<br>
[Documentación - Ejemplos para Lenguajes](https://documenter.getpostman.com/view/1431398/TzJx8bqc#f910e6f8-6a3f-41cf-8a5f-ec1e1f842637 "Clic")<br>

## Manuales adicionales

### Conexión
Conexión remota al servidor: [Guía](https://drive.google.com/file/d/1pC0-M7jtopujc-Zhrt43eMiIRYV5z6sy/view?usp=sharing "Clic")<br>
Guía acceso SSH - Putty: [Guía](https://drive.google.com/file/d/1BdfbV0QHK6LVlhbZlKNZaDXvdaySNO4M/view?usp=sharing "Clic")<br>
Conexión servidor Winscp: [Guía](https://drive.google.com/file/d/1f2QI2YUUOGGtaqc6mMj1r2rQGgkftd5x/view?usp=sharing "Clic")<br>
Montar proyecto en /home: [Guía](https://drive.google.com/file/d/17PLjrQq1guQiALZ4PcAMwQnbseiZdTtT/view?usp=sharing "Clic")<br>

### Manipulación de archivos dentro del servidor
Documentación del archivo .ENV: [Guía](https://drive.google.com/file/d/1FeCQmD4jplPBcMvq4TBDzOiZfnkNAABg/view?usp=sharing "Clic")<br>
Incrementar recursos - servidor: [Guía](https://drive.google.com/file/d/1Wj6eGv0QN11MgvQ-Y4QUyqcRfaN4seUW/view?usp=sharing "Clic")<br>
Incrementar recursos - aplicación: [Guía](https://drive.google.com/file/d/1eX4BkjzOIuEobhZIJScOJI2ee5d6S7U0/view?usp=sharing "Clic")<br>
Configuracion de correo electrónico emisor: [Guía](https://drive.google.com/file/d/1a41ZgkPoiXIyJK-lcAkXFalJRWlATOPZ/view?usp=sharing "Clic")<br>
Configuracion de correo emisor por cliente: [Guía](https://drive.google.com/file/d/1BIHh3tQB5tJg9p536vj3913fKdNOiplT/view?usp=sharing "Clic")<br>
Manual - Cambio de dominio: [Guía](https://drive.google.com/file/d/1xIz3RkexgL0VlwfVBTrXzvCSGV85pFFi/view?usp=sharing "Clic")<br>
Linux - Eliminar temporales: [Guía](https://drive.google.com/file/d/1ND9lLcpyfYCEin451qJ0M1pCKxmpbX4N/view?usp=sharing "Clic")<br>
Linux - Eliminar archivos por extensión: [Guía](https://drive.google.com/file/d/1mfL9cyJ591TD2gjaAd-6hO8PbT69JyFT/view?usp=sharing "Clic")<br>
Configuración servidor alterno SUNAT: [Guía](https://drive.google.com/file/d/1PLbCuhC7_2oHPrqbNioxYAI6nkFdc3Ap/view?usp=sharing "Clic")<br>
Habilitar debug: [Guía](https://drive.google.com/file/d/1KrloOMSDcFfLriq82DW1bd9O7lQFv6H5/view?usp=sharing "Clic")<br>
Configuración de API RUC/DNI (APIPERU): [Guía](https://drive.google.com/file/d/1kLpnKxcCXGm8uUG75zrY0TIDIMKUTDz7/view?usp=sharing "Clic")<br>
Configuración de tareas programadas (crontab-LAMP): [Guía](https://drive.google.com/file/d/1gR08nuyelxs4bQP6c9y_KztLw8H5qbNf/view?usp=sharing "Clic")<br>

### Base de datos
Guía acceso a base de datos: [Guía](https://drive.google.com/file/d/15LtxOmP3lWF3Q9krR5nwWrLZqqGvIyyB/view?usp=sharing "Clic")<br>

### Docker
Iniciar servicios docker: [Guía](https://drive.google.com/file/d/14kIHNclpL7Dc3z7rzxOJTDbeCJ7mHXZL/view?usp=sharing "Clic")<br>
Guía generar backup: [Guía](https://drive.google.com/file/d/1e7rBSNAlStQqIQvQgj94FqqvtET_UtBn/view?usp=sharing "Clic")<br>
Restauración de Mysql|Docker: [Guía](https://drive.google.com/file/d/1_TDNkflAODVmymKDh-8uEmDQiqz2IflS/view?usp=sharing "Clic")<br>

### Servidores
Guía incrementar espacio disco: [Guía](https://drive.google.com/file/d/1flzFaLlMThbCI_58ve2a3v1TDBtluSys/view?usp=sharing "Clic")<br>
Limpiar inodes: [Guía](https://drive.google.com/file/d/11P2wDBP6u0u_pkb5YdnyewjY2T5QDubf/view?usp=sharing "Clic")<br>
Migración servidor: [Guía](https://drive.google.com/file/d/12MdHQCErv5TL1R569veecG4ymCLKGkOl/view?usp=sharing "Clic")<br>
Manual de configuración offline: [Guía](https://drive.google.com/file/d/1MZlOrW0IVANSfzDpG6cxqA_EUsVRIfc4/view?usp=sharing "Clic")<br>
Habilitar puertos en Google Cloud: [Manual](https://drive.google.com/file/d/1fGuW4iSlXjUhn00p4K1vqxEy4rMRupjg/view?usp=sharing "clic")<br>

### Funcionalidades
Impresión automática: [Guía](https://docs.google.com/document/d/1PVe62AiuuuR-kC8KCBFuvOWj0Ag_YdRA/edit?usp=sharing&ouid=115578596704941457505&rtpof=true&sd=true "Clic")<br>
ICBPER en POS: [Guía](https://drive.google.com/file/d/1P_2tIUPIwNCOXeo2R0A_ego-zEBP6O-H/view?usp=sharing "Clic")<br>
Módulo Farmacia: [Guía](https://docs.google.com/document/d/1Cy4dnpxRNdVFWL2R3jlZ2qQW-p_wf2p8/edit?usp=sharing&ouid=115578596704941457505&rtpof=true&sd=true "Clic")<br>
Plantilla personalizada: [Guía](https://docs.google.com/document/d/1CykI1Njg6FpLd6Jyx-ojdleNjkwtP_2W/edit?usp=sharing&ouid=115578596704941457505&rtpof=true&sd=true "Clic")<br>

### Instalación Local
Acceso red local - laragon: [Guía](https://drive.google.com/file/d/1gRU4DuksFjLjVZYpuPkRaLv4iZ49SDgg/view?usp=sharing "Clic")<br>
YouTube Tutorial Instalación Local: [YouTube](https://youtu.be/kWdb86reI00 "Clic")<br>

### Errores comunes
Procedimiento para solucionar error 1033 SUNAT: [Guía](https://drive.google.com/file/d/1_h1CHvB9J2EKY-kFaXV-LVPGm9Oy7FF-/view?usp=sharing "Clic")<br>
YouTube Tutorial para solucionar error 1033 SUNAT: [YouTube](https://www.youtube.com/watch?v=CyKYM8iG3QY "Clic")
<br>


### No clasificados
Recreación de documentos: [Guía](https://drive.google.com/file/d/1fD2-XN4eavBEbEXGJuxEbjbqR_mMGp0K/view?usp=sharing "Clic")<br>
Manual de cambios privados: [Guía](https://drive.google.com/file/d/1bUFNi6JmOB70MkfkA76lx37skF0b6LDv/view?usp=sharing "Clic")<br>
Validador documentos: [Guía](https://drive.google.com/file/d/1Q8SblYp-fd1x30emqeNO6qPTx_XyjaJE/view?usp=sharing "Clic")<br>

## Factura Perú

nexSoft<br>
guillermo.cornejo.a@outlook.com<br>
WhatsApp: 990411130<b>

## API RUC / DNI / Tipo de Cambio

Este proyecto usa **[migo.pe](https://api.migo.pe)** para consultas de RUC, DNI y tipo de cambio.

Obtén tu token en: [https://api.migo.pe](https://api.migo.pe)<br>
Configura en `.env`:
```
API_SERVICE_URL=https://api.migo.pe
API_SERVICE_TOKEN=tu_token_aqui
```




