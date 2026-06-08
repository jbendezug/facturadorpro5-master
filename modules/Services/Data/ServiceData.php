<?php

namespace Modules\Services\Data;

use GuzzleHttp\Client;
use App\Models\System\Configuration;

class ServiceData
{
    public static function service($type, $number)
    {
        $configuration = Configuration::first();

        $url = !empty($configuration->url_apiruc) ? trim($configuration->url_apiruc) : config('configuration.api_service_url');
        $token = !empty($configuration->token_apiruc) ? trim($configuration->token_apiruc) : config('configuration.api_service_token');

        if (self::isMigoProvider($url)) {
            return self::requestMigo($url, $token, $number);
        }

        $client = new Client(['base_uri' => $url, 'verify' => false]);
        $parameters = [
            'http_errors' => false,
            'connect_timeout' => 5,
            'headers' => [
                'Authorization' => 'Bearer '.$token,
                'Accept' => 'application/json',
            ],
        ];

        $res = $client->request('GET', '/api/'.$type.'/'.$number, $parameters);
        $response = json_decode($res->getBody()->getContents(), true);

        return $response;
    }

    private static function isMigoProvider($url)
    {
        $source = strtolower((string) $url);

        return strpos($source, 'api.migo.pe') !== false || strpos($source, '/api/v1/ruc') !== false;
    }

    private static function requestMigo($url, $token, $number)
    {
        $base = rtrim((string) $url, '/');
        $endpoint = strpos(strtolower($base), '/api/v1/ruc') !== false ? $base : $base . '/api/v1/ruc';

        $client = new Client(['verify' => false]);
        $res = $client->request('POST', $endpoint, [
            'http_errors' => false,
            'connect_timeout' => 8,
            'headers' => [
                'Content-Type' => 'application/json',
                'Accept' => 'application/json',
            ],
            'json' => [
                'token' => $token,
                'ruc' => $number,
            ],
        ]);

        $data = json_decode($res->getBody()->getContents(), true);

        if (!is_array($data)) {
            return ['success' => false, 'message' => 'Respuesta invalida de API Migo'];
        }

        if (!array_key_exists('success', $data) || !$data['success']) {
            return ['success' => false, 'message' => $data['message'] ?? 'No se encontraron datos'];
        }

        return [
            'success' => true,
            'data' => [
                'nombre_o_razon_social' => $data['nombre_o_razon_social'] ?? ($data['nombre'] ?? ''),
            ],
        ];
    }

    /*
     * apiperu.net.pe --- para verificar envio de datos y url
     */
    public function validar_cpe($ruc,$usuario,$clave,$file)
    {
        try {
            $configuration = Configuration::first();
            //  dd($configuration->url_apiruc,$configuration->token_apiruc,$ruc,$usuario,$clave,$file);
            $this->client = new Client(['base_uri' => $configuration->url_apiruc, 'verify' => false, 'http_errors' => false]);
            $curl = [
                CURLOPT_URL => $configuration->url_apiruc.'/api/validar/txt',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_POSTFIELDS => array('file'=> new \CURLFILE(public_path('storage/txt/'.$file)),'ruc' => $ruc,'usuario_sol' => $usuario,'clave_sol' => $clave),
                CURLOPT_HTTPHEADER => array(
                    'Authorization: Bearer '.$configuration->token_apiruc,
                ),
            ];
            $responses = $this->client->request(strtoupper("POST"),'/api/validar/txt', [
                'curl' => $curl,
            ]);
            return $responses->getBody()->getContents();

        } catch (GuzzleHttp\Exception\RequestException $exception) {
            return $exception->getResponse()->getBody();
        }

    }
}
