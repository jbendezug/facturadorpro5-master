# Guía para IA: Mejoras UI/UX — Qué tocar, cómo y en qué orden

> **Regla de oro:** Nunca modificar lógica de negocio (métodos JS, Vuex actions/mutations,
> llamadas a API, cálculos de facturación). Solo tocar `<template>`, `<style>` y el
> registro de componentes en `app.js`.

---

## Estado real del proyecto (auditado 2026-06-07)

| Item | Estado actual |
|------|--------------|
| Vue | 2.7.16 ✅ |
| Element UI | 2.15.14 ✅ |
| Laravel Mix | 6.0.49 ✅ |
| sass (dart) | 1.69 ✅ |
| `require().default` | ✅ Aplicado en los 273 componentes |
| Lazy loading | ❌ Pendiente |
| `v-loading` en invoice.vue | ❌ Sin loading states |
| Sidebar responsive | ⚠️ Parcial (HTML existe, falta CSS) |
| DataTable unificada | ❌ Hay 8 variantes distintas |
| moment.js → dayjs | ❌ Pendiente |
| Bundle JS | 7.2MB (crítico) |

---

## FASE 1 — Quick wins (sin riesgo, impacto inmediato)

### 1.1 Loading states en invoice.vue

**Archivo:** `resources/js/views/tenant/documents/invoice.vue`

**Qué hacer:** Agregar `v-loading` de Element UI al wrapper principal y a
las secciones que consumen API. No tocar ningún método ni data.

```vue
<!-- ANTES: div raíz sin feedback -->
<template>
  <div>
    ...

<!-- DESPUÉS: wrapper con loading -->
<template>
  <div v-loading="loading" element-loading-text="Cargando..." element-loading-background="rgba(255,255,255,0.8)">
    ...
```

Buscar en el componente todos los lugares donde se hace `this.loading = true`
(ya existen) y verificar que tengan su correspondiente `v-loading` en el template.

**Impacto:** El usuario sabe que la app está trabajando. Elimina la sensación
de pantalla rota.

---

### 1.2 Sidebar responsive — solo agregar CSS

**El HTML ya existe.** El Blade ya tiene `toggle-sidebar-left` y la clase
`sidebar-left-opened`. Solo falta activarlo con CSS.

**Archivo:** `resources/sass/responsive.scss`

**Qué agregar al final del archivo:**

```scss
/* =============================================
   SIDEBAR RESPONSIVE — Mobile first
   Las clases toggle ya existen en el Blade,
   solo agregamos las transiciones y estados.
   ============================================= */

@media (max-width: 767px) {

  /* Sidebar oculto por defecto en mobile */
  .sidebar-left {
    position: fixed !important;
    left: -280px;
    top: 0;
    height: 100vh;
    z-index: 1050;
    transition: left 0.3s ease;
    overflow-y: auto;
  }

  /* Se abre cuando el JS de Porto agrega esta clase al <html> */
  html.sidebar-left-opened .sidebar-left {
    left: 0;
  }

  /* Overlay oscuro cuando el sidebar está abierto */
  html.sidebar-left-opened::after {
    content: '';
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1049;
  }

  /* El contenido principal no se desplaza */
  html.sidebar-left-opened .content-body {
    pointer-events: none;
  }
}
```

**Lo que NO tocar:** Los archivos `sidebar.blade.php` y `header.blade.php`.
El JS del tema (Porto) ya maneja el toggle.

---

### 1.3 Tablas responsive — wrapper de scroll horizontal

**Archivos:** Todos los componentes con `<el-table>` en
`resources/js/views/tenant/*/index.vue`

**Patrón a aplicar (solo en el template, no en el script):**

```vue
<!-- ANTES -->
<el-table :data="records" ...>

<!-- DESPUÉS: envolver sin tocar la lógica -->
<div class="table-scroll-wrapper">
  <el-table :data="records" ...>
</div>
```

**CSS en `resources/sass/custom.scss`:**

```scss
.table-scroll-wrapper {
  width: 100%;
  overflow-x: auto;
  -webkit-overflow-scrolling: touch;

  @media (max-width: 767px) {
    .el-table {
      min-width: 700px; /* Evita que las columnas se compriman demasiado */
    }
  }
}
```

**Componentes donde aplicar (por orden de uso frecuente):**
1. `resources/js/views/tenant/documents/index.vue`
2. `resources/js/views/tenant/items/index.vue`
3. `resources/js/views/tenant/persons/index.vue`
4. Todos los `modules/*/Resources/assets/js/views/index.vue`

---

### 1.4 Botones y inputs touch-friendly

**Archivo:** `resources/sass/custom.scss`

**Qué agregar:**

```scss
/* Touch targets — mínimo 44px según WCAG */
@media (max-width: 767px) {
  .el-button {
    min-height: 44px;
    padding: 10px 16px;
  }

  .el-input__inner,
  .el-select .el-input__inner {
    height: 44px;
    font-size: 16px; /* Evita zoom automático en iOS */
  }

  /* Botones de acción en tablas más fáciles de tocar */
  .el-table .el-button--mini {
    min-height: 36px;
    padding: 6px 10px;
  }
}
```

---

## FASE 2 — Mejoras de UX (impacto medio, riesgo bajo)

### 2.1 Modales full-screen en mobile

**Patrón:** Agregar la prop `:fullscreen` condicionalmente a todos los
`<el-dialog>`. No tocar la lógica de apertura/cierre.

```vue
<!-- En cada componente con el-dialog, agregar :fullscreen -->
<el-dialog
  :title="dialogTitle"
  :visible.sync="dialogVisible"
  :fullscreen="$isMobile"
  ...
>
```

**Agregar en `app.js` (antes de `new Vue`):**

```js
// Detectar mobile para usar en templates
Vue.prototype.$isMobile = window.innerWidth <= 767;
window.addEventListener('resize', () => {
  Vue.prototype.$isMobile = window.innerWidth <= 767;
});
```

---

### 2.2 Skeleton screens en listas

**Solo aplicar en componentes `index.vue` que hagan fetch al montar.**

```vue
<template>
  <div>
    <!-- Skeleton mientras carga -->
    <template v-if="isLoading">
      <el-skeleton :rows="8" animated />
    </template>

    <!-- Tabla real (sin cambios) -->
    <div v-else class="table-scroll-wrapper">
      <el-table :data="records" ...>
        <!-- columnas sin cambios -->
      </el-table>
    </div>
  </div>
</template>
```

Buscar en cada `index.vue` la variable que controla el estado de carga
(generalmente `loading` o `isLoading`) y usarla. No crear variables nuevas.

---

### 2.3 Notificaciones toast consistentes

Actualmente el sistema usa `this.$message()` y `this.$notify()` mezclados,
con distintos estilos y duraciones.

**Crear mixin:** `resources/js/mixins/notifications.js`

```js
// Solo agregar — no modificar los métodos existentes que ya usan $message
export default {
  methods: {
    notifySuccess(message, title = 'Éxito') {
      this.$notify({ title, message, type: 'success', duration: 3000 });
    },
    notifyError(message, title = 'Error') {
      this.$notify({ title, message, type: 'error', duration: 5000 });
    },
    notifyWarning(message, title = 'Atención') {
      this.$notify({ title, message, type: 'warning', duration: 4000 });
    },
  }
};
```

**Registrar globalmente en `app.js`:**

```js
import NotificationsMixin from './mixins/notifications';
Vue.mixin(NotificationsMixin);
```

Los métodos existentes (`this.$message`) siguen funcionando. El mixin solo
agrega opciones nuevas.

---

## FASE 3 — Performance (impacto alto, riesgo medio)

### 3.1 Lazy loading de componentes

**⚠️ ADVERTENCIA CRÍTICA:** El proyecto usa `require('./comp.vue').default`.
Para migrar a lazy loading con `import()`, hay que cambiar el patrón de
registro. Hacerlo en una rama separada y probar componente por componente.

**Patrón de migración:**

```js
// ANTES (síncrono — lo que hay ahora)
Vue.component('tenant-documents-index',
  require('./views/tenant/documents/index.vue').default
);

// DESPUÉS (lazy — cargar solo cuando se necesita)
Vue.component('tenant-documents-index',
  () => import('./views/tenant/documents/index.vue')
);
// Con import() dinámico NO se necesita .default — el bundler lo resuelve solo
```

**Orden de migración (de mayor a menor tamaño):**

| Componente | Tamaño aprox. | Migrar primero |
|---|---|---|
| `invoice.vue` | 3,749 líneas | ✅ Sí |
| `item.vue` (partial) | 1,694 líneas | ✅ Sí |
| Todos los `index.vue` de módulos | ~300 líneas c/u | ✅ Sí |
| Componentes de configuración | ~200 líneas c/u | Después |
| Componentes compartidos (DataTable, InputService) | Pequeños | ❌ No (dejar síncronos) |

**Configurar chunks por módulo en `webpack.mix.js`:**

```js
mix.webpackConfig({
  output: {
    chunkFilename: 'js/chunks/[name].[contenthash].js',
  },
  // ... resto del config existente
});
```

---

### 3.2 moment.js → dayjs

**Archivo:** `resources/js/app.js`

**Paso 1 — Instalar:**
```bash
npm install dayjs
```

**Paso 2 — Reemplazar en app.js:**
```js
// ANTES
import moment from 'moment';

// DESPUÉS
import dayjs from 'dayjs';
import 'dayjs/locale/es';
dayjs.locale('es');
const moment = dayjs; // Alias temporal — los usos existentes no cambian
```

Los filtros que usan `moment(date).format(...)` seguirán funcionando porque
`dayjs` tiene la misma API de `.format()`. Solo algunos métodos avanzados
difieren.

**Ahorro:** ~70KB en el bundle final.

---

### 3.3 Unificar DataTables

**Hay 8 variantes:** `DataTable.vue`, `DataTable1.vue`, `DataTableDocuments.vue`,
`DataTableDispatch.vue`, `DataTablePaymentReceipt.vue`, `DataTableQuotation.vue`,
`DataTableSaleNote.vue`, `DataTableResource.vue`, `DataTableTransfers.vue`

**Estrategia:** No reemplazar — crear `DataTableUnified.vue` en paralelo y
migrar las vistas nuevas a ella. Las existentes siguen funcionando.

```vue
<!-- resources/js/components/DataTableUnified.vue -->
<template>
  <div class="table-scroll-wrapper">
    <el-table
      v-loading="loading"
      :data="data"
      stripe
      border
      size="mini"
      v-bind="$attrs"
    >
      <slot />
    </el-table>

    <el-pagination
      v-if="pagination"
      layout="total, sizes, prev, pager, next"
      :total="total"
      :page-sizes="[15, 30, 50, 100]"
      @size-change="$emit('size-change', $event)"
      @current-change="$emit('page-change', $event)"
    />
  </div>
</template>

<script>
export default {
  name: 'DataTableUnified',
  inheritAttrs: false,
  props: {
    data:       { type: Array,   default: () => [] },
    loading:    { type: Boolean, default: false },
    pagination: { type: Boolean, default: true },
    total:      { type: Number,  default: 0 },
  }
};
</script>
```

---

## Lo que NUNCA tocar

```
app/CoreFacturalo/           ← Lógica SUNAT, XML, firma digital
app/Models/                  ← Modelos Eloquent
app/Http/Controllers/        ← Controladores
resources/js/store/          ← Vuex state, mutations, actions, getters
routes/                      ← Rutas web y API
modules/*/src/               ← Lógica PHP de módulos
```

---

## Checklist de validación por componente modificado

Antes de hacer commit de cualquier cambio de UI, verificar:

- [ ] El componente compila sin errores (`npm run dev`)
- [ ] Los datos siguen mostrándose correctamente
- [ ] Las acciones (guardar, editar, eliminar) siguen funcionando
- [ ] En mobile (320px) no hay overflow horizontal no controlado
- [ ] En tablet (768px) el sidebar colapsa correctamente
- [ ] Los loading states se muestran y ocultan correctamente
- [ ] No hay errores en la consola del navegador (F12)

---

## Archivos de referencia

| Propósito | Archivo |
|-----------|---------|
| Estilos globales responsive | `resources/sass/responsive.scss` |
| Estilos personalizados | `resources/sass/custom.scss` |
| Variables SCSS | `resources/sass/variable.scss` |
| Registro de componentes | `resources/js/app.js` |
| Mixins globales | `resources/js/mixins/` |
| Componentes compartidos | `resources/js/components/` |
| Layout principal | `resources/views/tenant/layouts/app.blade.php` |
| Sidebar Blade | `resources/views/tenant/layouts/partials/sidebar.blade.php` |
| Header Blade | `resources/views/tenant/layouts/partials/header.blade.php` |
