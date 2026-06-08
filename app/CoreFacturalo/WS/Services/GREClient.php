<?php

namespace App\CoreFacturalo\WS\Services;

use App\CoreFacturalo\WS\Services\SunatEndpoints;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;

/**
 * Cliente HTTP para la API REST de Guía de Remisión Electrónica (GRE) de SUNAT.
 *
 * Reemplaza al WsClient (SOAP) para el tipo 'dispatch' cuando la empresa
 * tiene habilitado el nuevo esquema GRE (use_gre = true).
 *
 * Referencia: Manual GRE SUNAT — API REST v1
 * Endpoint producción: https://api-cpe.sunat.gob.pe/v1/contribuyente/gem/comprobantes/{ruc}/guiaremision
 * Endpoint beta:       https://gre-test.nubefact.com/v1/contribuyente/gem/comprobantes/{ruc}/guiaremision
 */
class GREClient
{

    /** @var OAuthSunatService */
    private $oauthService;

    /** @var bool */
    private $isDemo;

    /** @var string */
    private $ruc;

    /**
     * @param OAuthSunatService $oauthService Servicio de autenticación OAuth
     * @param string            $ruc          RUC de la empresa emisora
     * @param bool              $isDemo       true = usar ambiente beta
     */
    public function __construct(OAuthSunatService $oauthService, string $ruc, bool $isDemo = false)
    {
        $this->oauthService = $oauthService;
        $this->ruc          = $ruc;
        $this->isDemo       = $isDemo;
    }

    /**
     * Envía la guía de remisión firmada a SUNAT como JSON con el XML en base64.
     *
     * @param  string $filename Nombre del archivo sin extensión (ej: "20123456789-09-T001-00001")
     * @param  string $xmlSigned Contenido del XML firmado
     * @return GREResult
     */
    public function send(string $filename, string $xmlSigned): GREResult
    {
        $result = new GREResult();

        try {
            $token = $this->oauthService->getToken();
            $response = $this->doRequest($filename, $xmlSigned, $token);
            $result->setSuccess(true)
                   ->setCode($response['codRespuesta'] ?? '0')
                   ->setDescription($response['desRespuesta'] ?? 'Aceptado')
                   ->setNumTicket($response['numTicket'] ?? null)
                   ->setRawResponse($response);

        } catch (\Exception $e) {
            // Si el error es 401, intentar renovar el token una vez
            if ($this->is401Error($e)) {
                try {
                    $token = $this->oauthService->refreshToken();
                    $response = $this->doRequest($filename, $xmlSigned, $token);
                    $result->setSuccess(true)
                           ->setCode($response['codRespuesta'] ?? '0')
                           ->setDescription($response['desRespuesta'] ?? 'Aceptado')
                           ->setNumTicket($response['numTicket'] ?? null)
                           ->setRawResponse($response);
                } catch (\Exception $retryException) {
                    $result->setSuccess(false)
                           ->setCode('GRE_ERROR')
                           ->setDescription($retryException->getMessage());
                }
            } else {
                $result->setSuccess(false)
                       ->setCode('GRE_ERROR')
                       ->setDescription($e->getMessage());
            }
        }

        return $result;
    }

    /**
     * Ejecuta la petición HTTP POST a la API GRE de SUNAT.
     *
     * @param  string $filename
     * @param  string $xmlSigned
     * @param  string $token
     * @return array
     * @throws \Exception
     */
    private function doRequest(string $filename, string $xmlSigned, string $token): array
    {
        $url = $this->buildUrl();

        $client = new Client([
            'timeout'         => 30,
            'connect_timeout' => 15,
        ]);

        try {
            $response = $client->post($url, [
                'headers' => [
                    'Authorization' => 'Bearer ' . $token,
                    'Content-Type'  => 'application/json',
                    'Accept'        => 'application/json',
                ],
                'json' => [
                    'archivo' => [
                        'nomArchivo' => $filename . '.xml',
                        'arcGreZip'  => base64_encode($xmlSigned),
                        'hashZip'    => hash('sha256', $xmlSigned),
                    ],
                ],
            ]);

            $body = json_decode($response->getBody()->getContents(), true);

            if (json_last_error() !== JSON_ERROR_NONE) {
                throw new \Exception('GRE: respuesta de SUNAT no es JSON válido.');
            }

            return $body;

        } catch (RequestException $e) {
            $statusCode   = $e->hasResponse() ? $e->getResponse()->getStatusCode() : 0;
            $responseBody = $e->hasResponse()
                ? $e->getResponse()->getBody()->getContents()
                : 'Sin respuesta del servidor';

            throw new \Exception(
                "GRE HTTP {$statusCode}: {$responseBody}",
                $statusCode
            );
        }
    }

    /**
     * Construye la URL del endpoint reemplazando {ruc}.
     */
    private function buildUrl(): string
    {
        $base = $this->isDemo ? SunatEndpoints::GRE_BETA : SunatEndpoints::GRE_PRODUCCION;
        return str_replace('{ruc}', $this->ruc, $base);
    }

    /**
     * Detecta si la excepción corresponde a un error HTTP 401.
     */
    private function is401Error(\Exception $e): bool
    {
        return $e->getCode() === 401;
    }
}
