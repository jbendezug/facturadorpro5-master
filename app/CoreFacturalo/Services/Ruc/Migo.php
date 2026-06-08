<?php

namespace App\CoreFacturalo\Services\Ruc;

use App\Models\System\Configuration;
use Illuminate\Support\Facades\Cache;

class Migo
{
    public static function search($number)
    {
        if (strlen($number) !== 11) {
            return ['success' => false, 'message' => 'RUC tiene 11 dígitos.'];
        }

        return Cache::remember('ruc_' . $number, now()->addHours(24), function () use ($number) {
            [$url, $token] = self::resolveCredentials();

            if (empty($token)) {
                return ['success' => false, 'message' => 'Token de consulta no configurado.'];
            }

            if (self::isMigoProvider($url)) {
                return self::searchMigo($number, $url, $token);
            }

            return self::searchApiPeru($number, $url, $token);
        });
    }

    private static function searchMigo($number, $url, $token)
    {
        $endpoint = rtrim((string) $url, '/');
        if (stripos($endpoint, '/api/v1/ruc') === false) {
            $endpoint .= '/api/v1/ruc';
        }

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL            => $endpoint,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT        => 10,
            CURLOPT_CUSTOMREQUEST  => 'POST',
            CURLOPT_POSTFIELDS     => json_encode(['token' => $token, 'ruc' => $number]),
            CURLOPT_HTTPHEADER     => ['Content-Type: application/json', 'Accept: application/json'],
        ]);

        $response = curl_exec($curl);
        $err      = curl_error($curl);
        curl_close($curl);

        if ($err || !$response) {
            return ['success' => false, 'message' => 'Conexión fallida con API Migo.'];
        }

        $data = json_decode($response, true);

        if (!isset($data['success']) || !$data['success']) {
            return ['success' => false, 'message' => $data['message'] ?? 'Datos no encontrados.'];
        }

        return ['success' => true, 'data' => $data];
    }

    private static function searchApiPeru($number, $url, $token)
    {
        $endpoint = rtrim((string) $url, '/') . '/api/ruc/' . $number;

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL            => $endpoint,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT        => 10,
            CURLOPT_CUSTOMREQUEST  => 'GET',
            CURLOPT_HTTPHEADER     => [
                'Authorization: Bearer ' . $token,
                'Accept: application/json',
            ],
        ]);

        $response = curl_exec($curl);
        $err      = curl_error($curl);
        curl_close($curl);

        if ($err || !$response) {
            return ['success' => false, 'message' => 'Conexión fallida con API Migo.'];
        }

        $data = json_decode($response, true);

        if (!isset($data['success']) || !$data['success']) {
            return ['success' => false, 'message' => $data['message'] ?? 'Datos no encontrados.'];
        }

        return ['success' => true, 'data' => $data['data'] ?? $data];
    }

    private static function resolveCredentials()
    {
        $configuration = Configuration::first();
        $url = $configuration ? trim((string) $configuration->url_apiruc) : '';
        $token = $configuration ? trim((string) $configuration->token_apiruc) : '';

        if ($token === 'false') {
            $token = '';
        }

        if (empty($url)) {
            $url = (string) config('configuration.api_service_url', 'https://api.migo.pe');
        }

        if (empty($token)) {
            $token = (string) config('configuration.api_service_token');
        }

        return [$url, $token];
    }

    private static function isMigoProvider($url)
    {
        $source = strtolower((string) $url);

        return strpos($source, 'api.migo.pe') !== false || strpos($source, '/api/v1/ruc') !== false;
    }
}
