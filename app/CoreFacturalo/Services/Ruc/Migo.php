<?php

namespace App\CoreFacturalo\Services\Ruc;

class Migo
{
    public static function search($number)
    {
        if (strlen($number) !== 11) {
            return ['success' => false, 'message' => 'RUC tiene 11 dígitos.'];
        }

        $token = config('configuration.api_service_token');
        $url   = config('configuration.api_service_url', 'https://api.migo.pe') . '/api/v1/ruc';

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL            => $url,
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
}
