Estado actual del proyecto - GRE UI
Proyecto: Facturador Pro 5 (Laravel 10 + Vue 2 + Docker)
Ruta workspace: facturadorpro5-master

Qué se hizo
Se agregó sección GRE a dos archivos Vue:
resources/js/views/tenant/companies/form.vue — línea ~317 con <template v-if="true"> (temporalmente sin condición para debug)
resources/js/views/system/companies/form.vue — al final del formulario
Se compiló con npm run dev → public/js/app.js compilado a las 19:07:40 con hash 403736e9...
La BD ya tiene los campos: use_gre, gre_client_id, gre_client_secret en tenancy.companies
Nginx ahora sirve JS con Cache-Control: no-cache (se modificó /docker/nginx/default.conf)
El problema
El browser del usuario NO muestra la sección GRE en el modal de configuración aunque:

El public/js/app.js SÍ contiene el texto (verificado con grep: 4 ocurrencias de use_gre, 31 de GRE)
El servidor sirve el JS correctamente (HTTP 200, Content-Length: 57044689)
Se puso v-if="true" para que aparezca incondicionalmente
Hipótesis no resueltas
El browser sigue usando versión cacheada del JS (antes de cambiar nginx, tenía Cache-Control: public, immutable, 1y)
El modal que se abre puede NO ser el tenant-companies-form sino otro componente (aunque las capturas muestran campos como "Certificado pfx" que sí están en el tenant form)
Posible problema de Service Worker cacheando el JS
Próximos pasos sugeridos
En la consola del browser (F12 → Console), ejecutar:

Verificar si hay Service Worker: F12 → Application → Service Workers
Si hay SW, hacer "Unregister" y recargar
Verificar en Network que app.js muestre size en MB (no "memory cache" ni "disk cache")
Archivos clave modificados
resources/js/views/tenant/companies/form.vue — sección GRE línea ~317
resources/js/views/system/companies/form.vue — sección GRE al final
app/Http/Requests/Tenant/CompanyRequest.php — validación GRE
app/Models/Tenant/Company.php — campos GRE en $fillable
database/migrations/tenant/2026_06_07_000001_tenant_add_gre_columns_to_companies.php — migración ejecutada
docker/nginx/default.conf — cache desactivado para JS/CSSmir
