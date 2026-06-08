<?php

namespace App\CoreFacturalo\WS\Services;

use App\CoreFacturalo\WS\Services\SunatEndpoints;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;
use Illuminate\Support\Facades\Cache;

/**
 * Gestiona el token OAuth 2.0 requerido por la API REST de SUNAT (GRE).
 *
 * SUNAT entrega tokens con TTL de 5 minutos (300 segundos).
 * Esta clase los almacena en caché (por RUC + client_id) para
 * reutilizarlos sin pedir uno nuevo en cada documento.
 *
 * Referencia: Manual GRE SUNAT — sección Autenticación OAuth 2.0
 * URL token: https://api-seguridad.sunat.gob.pe/v1/clientessol/{ruc}/oauth2/token/
 */
class OAuthSunatService
{
    /** Margen de seguridad en segundos antes de que expire el token */
    const EXPIRY_MARGIN = 30;

    /** @var string */
    private $ruc;

    /** @var string */
    private $clientId;

    /** @var string */
    private $clientSecret;

    /** @var bool */
    private $isDemo;

    /**
     * @param string $ruc          RUC de la empresa emisora
     * @param string $clientId     client_id otorgado por SUNAT SOL
     * @param string $clientSecret client_secret otorgado por SUNAT SOL
     * @param bool   $isDemo       true = usar ambiente beta
     */
    public function __construct(string $ruc, string $clientId, string $clientSecret, bool $isDemo = false)
    {
        $this->ruc          = $ruc;
        $this->clientId     = $clientId;
        $this->clientSecret = $clientSecret;
        $this->isDemo       = $isDemo;
    }

    /**
     * Retorna un access_token válido.
     * Si hay uno en caché y no ha expirado, lo reutiliza.
     * Si no, solicita uno nuevo a SUNAT y lo guarda en caché.
     *
     * @return string
     * @throws \Exception si SUNAT rechaza las credenciales
     */
    public function getToken(): string
    {
        $cacheKey = $this->buildCacheKey();

        if (Cache::has($cacheKey)) {
            return Cache::get($cacheKey);
        }

        return $this->requestNewToken($cacheKey);
    }

    /**
     * Fuerza la renovación del token, ignorando la caché.
     * Útil cuando SUNAT retorna 401 en una llamada posterior.
     *
     * @return string
     */
    public function refreshToken(): string
    {
        $cacheKey = $this->buildCacheKey();
        Cache::forget($cacheKey);
        return $this->requestNewToken($cacheKey);
    }

    /**
     * Solicita un nuevo token a SUNAT y lo almacena en caché.
     */
    private function requestNewToken(string $cacheKey): string
    {
        $url = $this->buildAuthUrl();

        $client = new Client([
            'timeout'         => 15,
            'connect_timeout' => 10,
        ]);

        try {
            $response = $client->post($url, [
                'form_params' => [
                    'grant_type'    => 'client_credentials',
                    'scope'         => 'https://api-cpe.sunat.gob.pe',
                    'client_id'     => $this->clientId,
                    'client_secret' => $this->clientSecret,
                ],
                'headers' => [
                    'Content-Type' => 'application/x-www-form-urlencoded',
                ],
            ]);

            $body  = json_decode($response->getBody()->getContents(), true);
            $token = $body['access_token'] ?? null;
            $ttl   = (int)($body['expires_in'] ?? 300);

            if (!$token) {
                throw new \Exception('SUNAT OAuth: no se recibió access_token en la respuesta.');
            }

            // Guardar en caché con margen de seguridad
            $cacheTtl = max(10, $ttl - self::EXPIRY_MARGIN);
            Cache::put($cacheKey, $token, $cacheTtl);

            return $token;

        } catch (RequestException $e) {
            $responseBody = $e->hasResponse()
                ? $e->getResponse()->getBody()->getContents()
                : 'Sin respuesta';

            throw new \Exception(
                "Error al obtener token OAuth SUNAT: HTTP {$e->getCode()} — {$responseBody}"
            );
        }
    }

    /**
     * Construye la URL de autenticación reemplazando {ruc}.
     */
    private function buildAuthUrl(): string
    {
        $base = $this->isDemo ? SunatEndpoints::GRE_OAUTH_BETA : SunatEndpoints::GRE_OAUTH_PRODUCCION;
        return str_replace('{ruc}', $this->ruc, $base);
    }

    /**
     * Clave única de caché para el token de esta empresa + cliente.
     */
    private function buildCacheKey(): string
    {
        return 'sunat_gre_token_' . $this->ruc . '_' . substr($this->clientId, 0, 8);
    }
}
