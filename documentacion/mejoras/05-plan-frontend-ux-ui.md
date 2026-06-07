# Plan de Mejoras Frontend - UX/UI Responsive

## Objetivo
Modernizar la interfaz visual y hacerla responsive (tablets/celulares) **sin modificar la lógica de negocio** del backend ni el store Vuex.

---

## Prerrequisitos (antes de empezar)

| # | Tarea | Por qué | ¿Bloqueante? |
|---|-------|---------|-------------|
| 1 | **Migrar `node-sass` → `sass`** | `node-sass` está deprecado y no funciona en Node 18+. Si no se migra, no se puede compilar el CSS. | **SÍ** |
| 2 | **Actualizar Laravel Mix 3 → 6** | Mix 3 no soporta dynamic imports (`import()`) para lazy loading. Bloquea la optimización de bundles. | **SÍ** |
| 3 | **Agregar viewport meta tag** | Sin `<meta name="viewport" content="width=device-width, initial-scale=1">` en las layouts Blade, el responsive no funciona. | **SÍ** |
| 4 | **Verificar versión de Element UI** | Element UI 2.13+ tiene soporte responsive parcial. Si es menor, actualizar a 2.15.x. | Recomendado |

---

## Pendientes - Fase 1: Infraestructura (1-2 días)

| # | Tarea | Detalle | Archivos |
|---|-------|---------|----------|
| 1.1 | Migrar `node-sass` → `sass` | `npm uninstall node-sass && npm install sass -D` | `package.json` |
| 1.2 | Actualizar Laravel Mix a 6.x | `npm install laravel-mix@^6.0` + ajustar `webpack.mix.js` | `webpack.mix.js`, `package.json` |
| 1.3 | Agregar viewport meta a layouts | `<meta name="viewport" content="width=device-width, initial-scale=1">` | `resources/views/**/layouts/*.blade.php` |
| 1.4 | Agregar CSS reset/base responsive | Normalizar estilos para mobile | `resources/sass/app.scss` |
| 1.5 | Configurar breakpoints SCSS | Variables `$mobile`, `$tablet`, `$desktop` | `resources/sass/_variables.scss` |

## Pendientes - Fase 2: Responsive Mobile/Tablet (3-5 días)

| # | Tarea | Cómo | Prioridad |
|---|-------|------|-----------|
| 2.1 | **Sidebar colapsable** | En mobile: menú hamburguesa. En tablet: iconos + tooltip | Alta |
| 2.2 | **Tablas scroll horizontal** | `el-table` con `overflow-x: auto` para que no se rompan en mobile | Alta |
| 2.3 | **Formularios responsive** | `el-form` con `layout="responsive"` o grid CSS | Alta |
| 2.4 | **Cards en lugar de tablas** | Vistas móviles: mostrar items como cards apilables | Media |
| 2.5 | **Bottom navigation** | En mobile: barra inferior con accesos rápidos | Media |
| 2.6 | **Modales full-screen** | En mobile: `el-dialog` con `fullscreen` | Media |
| 2.7 | **Inputs y botones touch** | Tamaño mínimo 44px para dedos | Alta |

### Ejemplo de sidebar responsive (solo CSS):

```scss
// resources/sass/_responsive.scss
.sidebar {
  @include mobile {
    position: fixed;
    left: -100%;
    transition: left 0.3s;
    z-index: 1000;
    
    &.is-open {
      left: 0;
    }
  }
  
  @include tablet {
    width: 64px;
    .menu-text { display: none; }
  }
}
```

### Ejemplo de tabla responsive:

```vue
<template>
  <!-- Sin cambiar lógica, solo wrapper -->
  <div class="table-responsive-wrapper">
    <el-table :data="data" stripe>
      <!-- columnas existentes, sin cambios -->
    </el-table>
  </div>
</template>

<style scoped>
.table-responsive-wrapper {
  @include mobile {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
}
</style>
```

## Pendientes - Fase 3: UX/UI (3-5 días)

| # | Tarea | Cómo | Prioridad |
|---|-------|------|-----------|
| 3.1 | **Loading states** | `v-loading` en tablas y botones | Alta |
| 3.2 | **Skeleton screens** | `el-skeleton` mientras carga data | Media |
| 3.3 | **Notificaciones toast** | `el-notification` para éxito/error | Alta |
| 3.4 | **Validación en tiempo real** | `el-form :rules` sin esperar submit | Alta |
| 3.5 | **Tooltips en acciones** | `el-tooltip` en botones críticos | Media |
| 3.6 | **Atajos de teclado** | F8 guardar, Escape cerrar, F1 buscar | Baja |
| 3.7 | **Confirmaciones mejoradas** | `el-message-box` con detalles | Media |
| 3.8 | **Tema claro/oscuro** | Variables CSS + toggle | Baja |

## Pendientes - Fase 4: Performance (2-3 días)

| # | Tarea | Cómo | Prioridad |
|---|-------|------|-----------|
| 4.1 | **Lazy loading componentes** | `() => import('./views/...vue')` | Alta |
| 4.2 | **Code splitting por ruta** | Chunks separados por módulo | Media |
| 4.3 | **Reemplazar moment.js → dayjs** | `npm uninstall moment && npm install dayjs` | Media |
| 4.4 | **Compresión assets** | Activar gzip en nginx | Baja |

## Lo que NO se toca

| Componente | Acción |
|------------|--------|
| Facturalo.php y CoreFacturalo | ❌ Sin cambios |
| Modelos (app/Models/) | ❌ Sin cambios |
| Controladores | ❌ Sin cambios |
| Store Vuex (state, mutations, actions) | ❌ Sin cambios |
| Rutas (web.php, api.php) | ❌ Sin cambios |
| Lógica de facturación SUNAT | ❌ Sin cambios |

---

## Resumen de esfuerzo

| Fase | Días | ¿Bloqueante? |
|------|------|-------------|
| **Fase 1** - Infraestructura | 1-2 | **SÍ** (prerrequisito) |
| **Fase 2** - Responsive | 3-5 | No |
| **Fase 3** - UX/UI | 3-5 | No |
| **Fase 4** - Performance | 2-3 | No |
| **Total** | **~10-15 días** | |

## Stack Propuesto

```
Actual:                  →   Nuevo:
Vue 2.5.7                →   Vue 2.7.x (último 2.x)
Element UI 2.13          →   Element UI 2.15.x
node-sass                →   sass (dart-sass)
Laravel Mix 3            →   Laravel Mix 6
moment.js                →   dayjs (opcional)
SCSS variables           →   Variables + mixins responsive
```

## Riesgos y mitigaciones

| Riesgo | Mitigación |
|--------|-----------|
| Element UI 2.13 no es fully responsive | Usar CSS media queries + clases utilitarias |
| node-sass falla en Node moderno | Migrar a dart-sass (sass) primero |
| Componentes grandes (3,749 líneas) difíciles de mantener | Solo tocar templates, no lógica JS |
| Conflictos al actualizar Mix 3→6 | Probar en rama separada primero |
