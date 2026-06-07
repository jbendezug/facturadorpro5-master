# Errores conocidos y soluciones

Registro de problemas detectados durante el desarrollo y migración del proyecto.
Consultar antes de debuggear para evitar perder tiempo en errores ya resueltos.

---

## 1. Interfaz Vue en blanco (pantalla vacía tras el sidebar)

**Síntoma:** El sidebar y el header cargan correctamente (Blade/PHP), pero el área
de contenido queda completamente en blanco. No hay mensaje de error visible.

**Causa:** Con **Webpack 5** (laravel-mix ≥ 6), los componentes `.vue` compilados
por `vue-loader` exportan sus definiciones usando ES module syntax (`export default`).
Al usar `require()` en vez de `import`, el resultado es un objeto wrapper:

```js
// Lo que devuelve require() con Webpack 5
{ default: ComponentOptions, __esModule: true }

// Vue espera recibir directamente
ComponentOptions
```

Cada `Vue.component('nombre', require('./comp.vue'))` recibe el wrapper vacío →
Vue monta `#main-wrapper` pero no reconoce ningún componente → pantalla en blanco.

**Solución:** Agregar `.default` a todos los `require` de archivos `.vue`:

```js
// ❌ Roto (Webpack 4 / CommonJS)
Vue.component('mi-componente', require('./views/MiComponente.vue'))

// ✅ Correcto (Webpack 5)
Vue.component('mi-componente', require('./views/MiComponente.vue').default)
```

Para aplicarlo masivamente en `resources/js/app.js`:

```bash
sed -i "s/require('\(.*\.vue\)')/require('\1').default/g" resources/js/app.js
```

Verificar que se aplicó correctamente:

```bash
grep -c "\.default" resources/js/app.js   # debe coincidir con el total de Vue.component
grep -c "Vue.component(" resources/js/app.js
```

Recompilar:

```bash
npm run dev
```

**Archivos afectados:** `resources/js/app.js`

---

## 2. CSS desincronizado con mix-manifest.json

**Síntoma:** Los estilos se ven desactualizados o rotos aunque `app.css` fue
recompilado. El hash del archivo real no coincide con el del manifest.

**Causa:** `build-css.js` fue ejecutado manualmente (o vía `npm run dev` antiguo
que usaba `node build-css.js && mix`). Esto sobreescribe `public/css/app.css`
**sin actualizar** `public/mix-manifest.json`. Laravel usa el manifest para generar
URLs con `?id=hash` — si el hash es incorrecto, el navegador puede servir un CSS
en caché incorrecto.

**Diagnóstico:**

```bash
# Comparar hash real vs hash en manifest
md5sum public/css/app.css
cat public/mix-manifest.json | grep app.css
# Los hashes deben coincidir
```

**Solución:** Siempre compilar con `mix`, nunca con `build-css.js` directamente:

```bash
npm run dev   # desarrollo
npm run prod  # producción
```

El `build-css.js` fue eliminado del flujo (`package.json`) — `mix` es el único
compilador de SCSS.

---

## 3. Orden de carga de scripts JS (app.js con defer en el head)

**Síntoma:** Errores de JavaScript del tipo `X is not defined` o componentes Vue
que fallan intermitentemente según la velocidad de carga.

**Causa:** `app.js` estaba cargado con `defer` en el `<head>`, mientras que
`manifest.js` y `vendor.js` (sus dependencias) se cargaban al final del `<body>`.
Aunque `defer` espera al DOM, no garantiza el orden respecto a scripts en el body.

**Solución:** Los tres scripts deben estar juntos al final del `<body>`, en orden:

```html
<!-- Al final del body, en este orden exacto -->
<script src="{{ mix('js/manifest.js') }}"></script>
<script src="{{ mix('js/vendor.js') }}"></script>
<script src="{{ mix('js/app.js') }}"></script>
```

**Archivo afectado:** `resources/views/tenant/layouts/app.blade.php`

---

## 4. Deprecaciones de Sass (warnings en compilación)

**Síntoma:** Durante `npm run dev` aparecen warnings como:
```
DEPRECATION WARNING [color-functions]: darken() is deprecated.
DEPRECATION WARNING [global-builtin]: Global built-in functions are deprecated.
```

**Causa:** El archivo `resources/sass/auth.scss` usa funciones Sass antiguas
(`darken()`, etc.) que serán eliminadas en Dart Sass 3.0.

**Impacto actual:** Solo warnings — el build completa correctamente.

**Solución futura:** Reemplazar en `auth.scss`:

```scss
// ❌ Deprecated
background-color: darken($blue, 15%);

// ✅ Moderno
background-color: color.adjust($blue, $lightness: -15%);
// o
background-color: color.scale($blue, $lightness: -25.5%);
```

---

## 5. `pro/style.scss` no se compila (archivo ignorado)

**Síntoma:** Cambios en `resources/sass/pro/style.scss` no tienen efecto en
producción.

**Causa:** El build solo compila `resources/sass/style.scss` (raíz). El archivo
`pro/style.scss` existe pero no está incluido en el entry point de webpack/mix.

**Solución:** Los cambios de estilos deben hacerse en `resources/sass/style.scss`
o en los archivos que este importa. `pro/style.scss` es una variante de referencia,
no el archivo activo.

---

## Checklist post-migración de Laravel

Al migrar versiones mayores de Laravel, verificar siempre:

- [ ] `require('./comp.vue')` → `require('./comp.vue').default` en `app.js`
- [ ] Ejecutar `npm run dev` completo (no `build-css.js` suelto)
- [ ] Verificar que `public/mix-manifest.json` tiene hashes sincronizados
- [ ] Orden de scripts en layouts: `manifest.js` → `vendor.js` → `app.js`
- [ ] `composer install` después de cambios en `composer.json`
- [ ] `php artisan config:clear && php artisan cache:clear` tras cambios de config
