# Bitacora de rendimiento

## Objetivo
Mejorar tiempos de respuesta del sistema sin introducir cambios de alto riesgo.

## Criterio de trabajo
- Aplicar optimizaciones pequenas, medibles y reversibles.
- Priorizar superficies de uso frecuente.
- Validar cada cambio antes de ampliar alcance.

## Avances

### 2026-06-07
- Se inicio la optimizacion por una superficie de bajo riesgo: `Configuracion -> Avanzado`.
- Se identifico que el endpoint `Tenant\\ConfigurationController::tables()` cargaba tablas maestras en cada visita.
- Se aplico cache por 30 minutos para:
  - `affectation_igv_types`
  - `global_discount_types`
- Archivo modificado:
  - `app/Http/Controllers/Tenant/ConfigurationController.php`

## Impacto esperado
- Menos consultas repetitivas a base de datos al abrir la configuracion avanzada.
- Menor tiempo de respuesta en una pantalla administrativa de uso frecuente.

## Validacion
- Sin errores reportados por el editor en el archivo modificado.
- No fue posible ejecutar `php -l` en este entorno porque no hay binario `php` disponible en terminal.

## Siguientes pasos propuestos
1. Cachear otras tablas maestras frecuentes en formularios grandes. ✅ Parcial
2. Revisar busqueda remota de clientes y documentos, donde hay mas impacto percibido.
3. Auditar endpoints con `all()` y `get()` sin paginacion en panel tenant/system.
4. Preparar una fase separada para cache/redis/config cache de despliegue.
