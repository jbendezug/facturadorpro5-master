<?php

namespace App\CoreFacturalo\Services\Dni;

use App\CoreFacturalo\Services\Helpers\Functions;
use App\CoreFacturalo\Services\Models\Person;

class Migo
{
    public static function search($number)
    {
        if (strlen($number) !== 8) {
            return [
                'success' => false,
                'message' => 'DNI tiene 8 digitos.'
            ];
        }

        $token = config('configuration.api_service_token');
        $url   = config('configuration.api_service_url', 'https://api.migo.pe') . '/api/v1/dni';

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL            => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT        => 10,
            CURLOPT_CUSTOMREQUEST  => 'POST',
            CURLOPT_POSTFIELDS     => json_encode(['token' => $token, 'dni' => $number]),
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

        $fullName = $data['nombre'] ?? '';

        $person                    = new Person();
        $person->number            = $number;
        $person->verification_code = Functions::verificationCode($number);
        $person->name              = $fullName;

        return ['success' => true, 'data' => $person];
    }
}
