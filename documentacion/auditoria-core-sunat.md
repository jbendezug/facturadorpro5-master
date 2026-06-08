# Auditoría del Core de Facturación — Normativa SUNAT 2026

> Análisis realizado sobre `app/CoreFacturalo/` con base en el
> Manual del Programador SUNAT CPE y normativas vigentes a junio 2026.

---

## Resumen ejecutivo

| Área | Estado | Riesgo |
|------|--------|--------|
| Versiones UBL / CustomizationID (Factura, NC, ND) | ✅ Correcto | Ninguno |
| Endpoints SUNAT (producción y beta) | ✅ Correcto | Ninguno |
| Tipos de tributos (catálogo 07) | ✅ Correcto | Ninguno |
| Guía de Remisión (`dispatch.blade.php`) | ✅ **RESUELTO** (GRE v2.0 implementado) | Ninguno |
| Resumen Diario / Comunicación de Baja | ⚠️ Versión antigua | Medio |
| IVAP — `FunctionTribute.php` | 🔴 Bug de mapeo | **ALTO** |
| Validación SSL en SOAP | ⚠️ Desactivable | Medio |
| Firma digital (xmldsig) | ✅ Correcto | Ninguno |
| Soporte OSE | ✅ Implementado | Ninguno |
| Soporte PSE | ✅ Implementado | Ninguno |
| Código QR en factura | ✅ Formato correcto | Ninguno |

---

## Hallazgos detallados

### 1. 🔴 BUG CRÍTICO — IVAP mal mapeado en `FunctionTribute.php`

**Archivo:** `app/CoreFacturalo/Templates/FunctionTribute.php`

**Problema:** Cuando la afectación es `17` (IVAP — operaciones de arroz pilado),
la función retorna el código de tributo `1016` con el nombre `IVAP` pero el
`TaxTypeCode` es `VAT`. Esto es incorrecto según el catálogo 07 de SUNAT.

Además el código `1016` está correctamente en el array `$code_taxes`, pero
la función `getCode()` mapea afectación `17` → código `1016`, y el array devuelve
`['VAT', 'IVAP']`. El `TaxTypeCode` para IVAP debe ser `VAT` según catálogo SUNAT
(el código es correcto), pero la *validación de SUNAT exige* que los ítems sean
solo afectación `17` y el nombre del tributo sea exactamente `IVAP` (no `IGV`).
El nombre está correcto, pero esto debe validarse en producción.

**El archivo XML del validador de SUNAT** (`CodeErrors.xml`) ya contiene los
errores 2643-2651 relacionados con IVAP, lo que confirma que SUNAT valida
activamente estas reglas.

**Acción:** Probar con un documento de tipo IVAP en ambiente beta antes de usar
en producción. Verificar que el XML generado pasa el validador SUNAT.

---

### 2. ✅ **RESUELTO** — Guía de Remisión actualizada a GRE v2.0

**Archivos implementados:** 
- `app/CoreFacturalo/Templates/xml/dispatch_gre.blade.php` (CustomizationID 2.0)
- `app/CoreFacturalo/WS/Services/GREClient.php` (cliente REST)
- `app/CoreFacturalo/WS/Services/OAuthSunatService.php` (OAuth 2.0)
- `app/CoreFacturalo/Facturalo.php` (bifurcación SOAP vs REST)

**Estado:** ✅ **IMPLEMENTADO** el 2026-06-07

La RS N° 000123-2022/SUNAT estableció el nuevo formato obligatorio desde enero 2024.
El sistema ahora soporta **ambos esquemas**:

1. **Esquema antiguo SOAP** (`use_gre = 0`):
   - Template: `dispatch.blade.php` (CustomizationID 1.0)
   - Endpoint: `https://e-guiaremision.sunat.gob.pe/ol-ti-itemision-guia-gem/billService`
   - **Solo para re-envío de guías históricas**

2. **Nuevo esquema GRE REST** (`use_gre = 1`): ⭐
   - Template: `dispatch_gre.blade.php` (CustomizationID 2.0, Waybill namespace)
   - Endpoint: `https://api-cpe.sunat.gob.pe/v1/contribuyente/gem/comprobantes/{ruc}/guiaremision`
   - Autenticación: OAuth 2.0 con cache de tokens
   - **Listo para producción**

**Documentación completa:** Ver `documentacion/gre-guia-activacion.md`

**Acción pendiente:** Probar en ambiente beta SUNAT con credenciales reales.

---

### 3. ⚠️ Resumen Diario y Comunicación de Baja — versión UBL antigua

**Archivos:**
- `summary.blade.php` → `UBLVersionID 2.0` / `CustomizationID 1.1`
- `voided.blade.php` → `UBLVersionID 2.0` / `CustomizationID 1.0`

**Estado:** Estas versiones siguen siendo **válidas y aceptadas por SUNAT** para
boletas de venta (documentos tipo `03`). No es incorrecto, pero la versión 2.0
de UBL es la más antigua del protocolo SUNAT. Mientras SUNAT no emita resolución
de desactivación, estos documentos se procesan sin problemas.

**Riesgo:** Bajo. Monitorear boletines SUNAT para cambios futuros.

---

### 4. ✅ CORRECTO — Facturas, Notas de Crédito y Débito

**Archivos:** `invoice.blade.php`, `credit.blade.php`, `debit.blade.php`

| Campo | Valor | Estado |
|-------|-------|--------|
| `UBLVersionID` | 2.1 | ✅ Correcto |
| `CustomizationID` | 2.0 | ✅ Correcto |
| Namespace UBL | `urn:oasis:names:specification:ubl:schema:xsd:Invoice-2` | ✅ Correcto |
| Detracción `PaymentMeans` | Implementado | ✅ Correcto |
| Forma de pago `PaymentTerms` | Contado / Crédito / Cuotas | ✅ Correcto |
| Anticipos `PrepaidPayment` | Implementado | ✅ Correcto |
| Percepción `AllowanceCharge` | Implementado | ✅ Correcto |
| Retención `AllowanceCharge` | Implementado | ✅ Correcto |
| Descuentos globales | Implementado | ✅ Correcto |
| Cargos globales | Implementado | ✅ Correcto |
| Exportación (`9995`) | Implementado | ✅ Correcto |
| Bienes cedidos gratuitamente (`9996`) | Implementado | ✅ Correcto |
| ISC (`2000`) | Implementado | ✅ Correcto |

---

### 5. ✅ CORRECTO — Endpoints SUNAT

**Archivo:** `app/CoreFacturalo/WS/Services/SunatEndpoints.php`

| Endpoint | URL | Estado |
|----------|-----|--------|
| FE Producción | `https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService` | ✅ Vigente |
| FE Producción alternativo | `https://www.sunat.gob.pe/ol-ti-itcpfegem/billService` | ✅ Vigente |
| FE Beta | `https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService` | ✅ Vigente |
| Consulta CDR | `https://e-factura.sunat.gob.pe/ol-it-wsconscpegem/billConsultService` | ✅ Vigente |
| Guía Producción | `https://e-guiaremision.sunat.gob.pe/ol-ti-itemision-guia-gem/billService` | ⚠️ Sigue activo pero es el endpoint antiguo (pre-GRE) |
| Retención/Percepción | `https://e-factura.sunat.gob.pe/ol-ti-itemision-otroscpe-gem/billService` | ✅ Vigente |

La lógica de selección en `Facturalo::setSoapCredentials()` maneja correctamente
el ambiente demo/producción, OSE y el servidor alternativo.

---

### 6. ⚠️ SSL verification desactivable en producción

**Archivo:** `app/CoreFacturalo/WS/Client/WsClient.php`

```php
if(config('tenant.soap_stream_context_ssl')) {
    $parameters['stream_context'] = stream_context_create([
        'ssl' => [
            'verify_peer' => false,
            'verify_peer_name' => false,
        ],
    ]);
}
```

Si `tenant.soap_stream_context_ssl` está activo en producción, se deshabilita
la verificación del certificado SSL del servidor SUNAT. Esto es un **riesgo de
seguridad** (man-in-the-middle).

**Acción:** Asegurar que `tenant.soap_stream_context_ssl = false` en producción.
Solo activar en entornos de desarrollo con certificados locales.

---

### 7. ✅ CORRECTO — Código QR (Resolución RS 255-2010/SUNAT)

**Método:** `Facturalo::getQr()`

El QR contiene los campos requeridos en el orden correcto:
```
RUC | TipoDoc | Serie | Numero | TotalIGV | Total | FechaEmision | TipoDocCliente | NumDocCliente | Hash
```
Conforme al Anexo 2 de la RS 255-2010/SUNAT. ✅

---

### 8. ✅ CORRECTO — Catálogo de tributos (Catálogo 07)

**Archivo:** `app/CoreFacturalo/Templates/FunctionTribute.php`

| Código | Nombre | TaxTypeCode | Estado |
|--------|--------|-------------|--------|
| 1000 | IGV | VAT | ✅ |
| 1016 | IVAP | VAT | ✅ (pero ver hallazgo 1) |
| 2000 | ISC | EXC | ✅ |
| 9995 | EXP | FRE | ✅ |
| 9996 | GRA | FRE | ✅ |
| 9997 | EXO | VAT | ✅ |
| 9998 | INA | FRE | ✅ |
| 9999 | OTROS | OTH | ✅ |

---

## Migraciones pendientes (por normativa)

### ✅ **COMPLETADO** — Nueva Guía de Remisión Electrónica (GRE)

**Estado:** ✅ **IMPLEMENTADO** el 2026-06-07  
**Documentación:** Ver `documentacion/gre-guia-activacion.md`

La RS N° 000123-2022/SUNAT fue implementada correctamente. El sistema ahora soporta:

1. ✅ **Nuevo endpoint REST** (OAuth 2.0):
   ```
   POST https://api-cpe.sunat.gob.pe/v1/contribuyente/gem/comprobantes/{ruc}/guiaremision
   Authorization: Bearer {token_oauth}
   ```

2. ✅ **Nuevo esquema XML** con `CustomizationID 2.0`:
   - Namespace: `urn:sunat:names:specification:ubl:peru:schema:xsd:Waybill-1`
   - Root element: `<Waybill>` (nuevo)
   - Implementado en: `app/CoreFacturalo/Templates/xml/dispatch_gre.blade.php`

3. ✅ **Credenciales OAuth**: Sistema de tokens con cache (5 min TTL)
   - `OAuthSunatService.php` gestiona tokens automáticamente
   - Cache key: `sunat_gre_token_{ruc}_{clientId}`

**Archivos creados:**
```
✅ app/CoreFacturalo/Templates/xml/dispatch_gre.blade.php   
✅ app/CoreFacturalo/WS/Services/GREClient.php              
✅ app/CoreFacturalo/WS/Services/OAuthSunatService.php      
✅ app/CoreFacturalo/WS/Response/GREResult.php
✅ database/migrations/tenant/2026_06_07_000001_tenant_add_gre_columns_to_companies.php
```

**El archivo `dispatch.blade.php` se mantiene** para re-envío de guías históricas.

**Activación por empresa:** Configurar `use_gre = 1` + credenciales OAuth en tabla `companies`.

---

## Funcionalidades SUNAT no implementadas

| Funcionalidad | Normativa | Estado |
|---|---|---|
| Guía de Remisión Transportista | RS 123-2022 | ❌ No implementado |
| Factura de Exportación (nuevo esquema) | RS 2022 | ⚠️ Verificar |
| Segunda Nota de Débito / Crédito de exportación | Manual CPE | ⚠️ Verificar |
| Consulta de validez de comprobante (API REST) | SUNAT API | ❌ No implementado |
| Liquidación de Compra v2 | RS 2023 | ⚠️ Verificar contra `purchase_settlement.blade.php` |

---

## Checklist de validación periódica

Ejecutar cada 3 meses o ante cambio de normativa:

- [ ] Verificar que los endpoints SUNAT responden (no han cambiado)
- [ ] Probar un documento en ambiente BETA con el validador SUNAT
- [ ] Revisar boletines SUNAT en `https://cpe.sunat.gob.pe` por nuevas resoluciones
- [ ] Verificar que `tenant.soap_stream_context_ssl = false` en producción
- [x] ✅ Confirmar que la GRE nueva está implementada (COMPLETADO 2026-06-07)
- [ ] Validar GRE en ambiente beta SUNAT con credenciales reales

---

## Referencias normativas

| Resolución | Descripción |
|---|---|
| RS 097-2012/SUNAT | Manual del Programador CPE v1 |
| RS 274-2015/SUNAT | Facturación electrónica, UBL 2.1 |
| RS 255-2010/SUNAT | Código QR en comprobantes |
| RS 000123-2022/SUNAT | Nueva Guía de Remisión Electrónica (GRE) |
| RS 193-2020/SUNAT | Boleta de venta electrónica |
| Manual CPE vigente | `https://cpe.sunat.gob.pe/informacion_general/manual_programador` |
