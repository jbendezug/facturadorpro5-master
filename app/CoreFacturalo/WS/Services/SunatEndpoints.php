<?php

namespace App\CoreFacturalo\WS\Services;

/**
 * Class SunatEndpoints.
 */
final class SunatEndpoints
{
    /**
     *  FACTURACION SERVICES.
     */
    const FE_BETA = 'https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService';
    const FE_HOMOLOGACION = 'https://www.sunat.gob.pe/ol-ti-itcpgem-sqa/billService';
    const FE_PRODUCCION = 'https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService';
    const FE_PRODUCCION_ALTERNATE = 'https://www.sunat.gob.pe/ol-ti-itcpfegem/billService';
    const FE_CONSULTA_CDR = 'https://e-factura.sunat.gob.pe/ol-it-wsconscpegem/billConsultService';

    /**
     * GUIA DE REMISION SERVICES — Esquema antiguo SOAP (CustomizationID 1.0).
     * Solo para re-envío de guías emitidas antes de 2024.
     * Para guías nuevas usar GRE_* (API REST, CustomizationID 2.0).
     */
    const GUIA_BETA = 'https://e-beta.sunat.gob.pe/ol-ti-itemision-guia-gem-beta/billService';
    const GUIA_PRODUCCION = 'https://e-guiaremision.sunat.gob.pe/ol-ti-itemision-guia-gem/billService';

    /**
     * GUIA DE REMISION ELECTRONICA (GRE) — Nuevo esquema REST (CustomizationID 2.0).
     * RS N° 000123-2022/SUNAT — vigente desde enero 2024.
     * Requiere autenticación OAuth 2.0 (OAuthSunatService) y GREClient.
     * El {ruc} se reemplaza en tiempo de ejecución.
     */
    const GRE_PRODUCCION = 'https://api-cpe.sunat.gob.pe/v1/contribuyente/gem/comprobantes/{ruc}/guiaremision';
    const GRE_BETA       = 'https://gre-test.nubefact.com/v1/contribuyente/gem/comprobantes/{ruc}/guiaremision';

    /**
     * OAuth 2.0 — Servidor de autenticación SUNAT para GRE.
     * El {ruc} se reemplaza en tiempo de ejecución.
     */
    const GRE_OAUTH_PRODUCCION = 'https://api-seguridad.sunat.gob.pe/v1/clientessol/{ruc}/oauth2/token/';
    const GRE_OAUTH_BETA       = 'https://gre-test.nubefact.com/v1/clientessol/{ruc}/oauth2/token/';

    /**
     * RETENCION Y PERCEPCION SERVICES.
     */
    const RETENCION_BETA = 'https://e-beta.sunat.gob.pe/ol-ti-itemision-otroscpe-gem-beta/billService';
    const RETENCION_PRODUCCION = 'https://e-factura.sunat.gob.pe/ol-ti-itemision-otroscpe-gem/billService';

    /**
     * WSDL Uri.
     */
    const WSDL_ENDPOINT = 'https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService?wsdl';
}
