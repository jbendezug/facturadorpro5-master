<?php

namespace App\CoreFacturalo\Services\Dni;

use App\CoreFacturalo\Services\Helpers\Functions;
use App\CoreFacturalo\Services\Models\Person;
use App\Models\System\Configuration;

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

        [$url, $token] = self::resolveCredentials();

        if (empty($token)) {
            return ['success' => false, 'message' => 'Token de consulta no configurado.'];
        }

        if (self::isMigoProvider($url)) {
            return self::searchMigo($number, $url, $token);
        }

        return self::searchApiPeru($number, $url, $token);
    }

    private static function searchMigo($number, $url, $token)
    {
        $endpoint = rtrim((string) $url, '/');
        if (stripos($endpoint, '/api/v1/dni') === false) {
            $endpoint .= '/api/v1/dni';
        }

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL            => $endpoint,
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

        $fullName = $data['nombre'] ?? ($data['data']['nombre'] ?? '');

        if (empty($fullName)) {
            return ['success' => false, 'message' => 'Datos no encontrados.'];
        }

        $person = new Person();
        $person->number = $number;
        $person->verification_code = Functions::verificationCode($number);
        $person->name = $fullName;

        return ['success' => true, 'data' => $person];
    }

    private static function searchApiPeru($number, $url, $token)
    {
        $endpoint = rtrim((string) $url, '/') . '/api/dni/' . $number;

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
        $err = curl_error($curl);
        curl_close($curl);

        if ($err || !$response) {
            return ['success' => false, 'message' => 'Conexión fallida con API externa.'];
        }

        $data = json_decode($response, true);

        if (!isset($data['success']) || !$data['success']) {
            return ['success' => false, 'message' => $data['message'] ?? 'Datos no encontrados.'];
        }

        $dniData = $data['data'] ?? [];
        $firstName = $dniData['apellido_paterno'] ?? '';
        $lastName = $dniData['apellido_materno'] ?? '';
        $names = $dniData['nombres'] ?? '';
        $fullName = trim(($dniData['nombre_completo'] ?? '') ?: ($firstName . ' ' . $lastName . ' ' . $names));

        if (empty($fullName)) {
            return ['success' => false, 'message' => 'Datos no encontrados.'];
        }

        $person = new Person();
        $person->number = $number;
        $person->verification_code = Functions::verificationCode($number);
        $person->name = $fullName;
        $person->first_name = $firstName;
        $person->last_name = $lastName;
        $person->names = $names;

        return ['success' => true, 'data' => $person];
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

        return strpos($source, 'api.migo.pe') !== false || strpos($source, '/api/v1/dni') !== false;
    }
}
