<?php

    namespace Modules\ApiPeruDev\Data;

    use App\Models\Tenant\Company;
    use App\Models\Tenant\ExchangeRate;
    use GuzzleHttp\Client;
    use App\Models\System\Configuration as SystemConfiguration;
    use App\Models\Tenant\Configuration as TenantConfig;
    use App\Models\System\TrackApiPeruServices as SystemTrackApiPeruService;
    use App\Models\Tenant\TrackApiPeruServices as TenantTrackApiPeruService;
    use Illuminate\Support\Facades\URL;

    class ServiceData
    {
        protected $client;
        /**
         * @var TenantTrackApiPeruService|SystemConfiguration
         */
        protected $trackApi;
        /**
         * @var SystemTrackApiPeruService|TenantTrackApiPeruService
         */
        protected $configuration;
        /** @var Company */
        protected $company;
        protected $parameters;
        protected $apiToken;

        public function __construct()
        {
            $prefix = env('PREFIX_URL',null);
            $prefix = !empty($prefix)?$prefix.".":'';
            $app_url = $prefix. env('APP_URL_BASE');
            $url =  $_SERVER['HTTP_HOST']??null;
            $company = null;
            // Desde admin
            $configuration = SystemConfiguration::query()->first();
            $trackApi = new SystemTrackApiPeruService();

            if($url !== $app_url) {
                // desde cliente
                $configuration = TenantConfig::query()->first();
                $trackApi = new TenantTrackApiPeruService();
                $company = Company::first();
                if ($configuration->UseCustomApiPeruToken() == false) {
                    $configuration = SystemConfiguration::query()->first();
                    $trackApi = new SystemTrackApiPeruService();
                }
            }

            $url = !empty($configuration->url_apiruc) ? $configuration->url_apiruc : config('configuration.api_service_url');
            $token = !empty($configuration->token_apiruc) ? $configuration->token_apiruc : config('configuration.api_service_token');
            $this->configuration = $configuration;
            $this->trackApi = $trackApi;
            $this->company = $company;


            $this->client = new Client(['base_uri' => $url]);
            $this->apiToken = $token;
            $this->parameters = [
                'http_errors' => false,
                'connect_timeout' => 10,
                'verify' => false,
                'headers' => [
                    'Authorization' => 'Bearer ' . $token,
                    'Accept' => 'application/json',
                ],
            ];
        }
        /**
         * 1 => sunat/dni
         * 2 => validacion_multiple_cpe
         * 3 => CPE
         * 4 => tipo_de_cambio
         * 5 => printer_ticket
         *
         * @param int $service
         */
        public function saveService($service = 0, $response = [])
        {

            if (isset($response['message']) &&
                strpos($response['message'], 'Ha superado la cantidad de consultas mensuales') !== false) {
                // Si se ha superado la cantidad, no hace nada.
                return $this;

            }
            $number = null;
            if(!empty($this->company)){
                $number = $this->company->number;
            }
            $this->trackApi->setService($number, $service);
            $this->trackApi->push();
            return $this;

        }

        protected function isMigoApi()
        {
            $baseUri = (string) $this->client->getConfig('base_uri');
            return strpos($baseUri, 'migo.pe') !== false;
        }

        public function service($type, $number)
        {
            if ($this->isMigoApi()) {
                $res = $this->client->request('GET', '/api/v1/' . $type, array_merge($this->parameters, [
                    'query' => [$type => $number, 'token' => $this->apiToken],
                ]));
            } else {
                $res = $this->client->request('GET', '/api/' . $type . '/' . $number, $this->parameters);
            }

            $body = $res->getBody()->getContents();
            $response = json_decode($body, true);

            $res_data = [];
            if ($response['success']) {
                // migo.pe devuelve los datos en la raíz (sin key 'data')
                // apiperu.dev los devuelve dentro de $response['data']
                $data = $this->isMigoApi() ? $response : ($response['data'] ?? []);

                if ($type === 'dni') {
                    $department_id = '';
                    $province_id = null;
                    $district_id = null;
                    $address = null;

                    if ($this->isMigoApi()) {
                        // migo.pe: ubigeo es string "150101" — 6 chars = district, 4 = province, 2 = department
                        $ubigeo_str = $data['ubigeo'] ?? '';
                        $address    = $data['direccion'] ?? null;
                        if (strlen($ubigeo_str) === 6) {
                            $district_id   = $ubigeo_str;
                            $province_id   = substr($ubigeo_str, 0, 4);
                            $department_id = substr($ubigeo_str, 0, 2);
                        }
                    } else {
                        $ubigeo      = $data['ubigeo'] ?? [];
                        $ubigeo_sunat = $data['ubigeo_sunat'] ?? '';
                        if (key_exists('source', $response) && $response['source'] === 'apiperu.dev') {
                            if (strlen($ubigeo_sunat)) {
                                $department_id = $ubigeo[0] ?? '';
                                $province_id   = $ubigeo[1] ?? null;
                                $district_id   = $ubigeo[2] ?? null;
                                $address       = $data['direccion'] ?? null;
                            }
                        } else {
                            $department_id = $ubigeo[0] ?? '';
                            $province_id   = $ubigeo[1] ?? null;
                            $district_id   = $ubigeo[2] ?? null;
                            $address       = $data['direccion'] ?? null;
                        }
                    }

                    $res_data = [
                        'name'          => $data['nombre'] ?? ($data['nombre_completo'] ?? ($data['nombres'] ?? '')),
                        'trade_name'    => '',
                        'location_id'   => $district_id,
                        'address'       => $address,
                        'department_id' => $department_id,
                        'province_id'   => $province_id,
                        'district_id'   => $district_id,
                        'condition'     => '',
                        'state'         => '',
                    ];
                }

                if ($type === 'ruc') {
                    $address       = '';
                    $department_id = null;
                    $province_id   = null;
                    $district_id   = null;

                    if ($this->isMigoApi()) {
                        // migo.pe: ubigeo es string "150141" — 6 chars = district, 4 = province, 2 = department
                        $ubigeo_str = $data['ubigeo'] ?? '';
                        $address    = $data['direccion'] ?? ($data['domicilio_fiscal'] ?? '');
                        if (strlen($ubigeo_str) === 6) {
                            $district_id   = $ubigeo_str;
                            $province_id   = substr($ubigeo_str, 0, 4);
                            $department_id = substr($ubigeo_str, 0, 2);
                        }
                    } else {
                        $ubigeo       = $data['ubigeo'] ?? [];
                        $ubigeo_sunat = $data['ubigeo_sunat'] ?? '';
                        if (key_exists('source', $response) && $response['source'] === 'apiperu.dev') {
                            if (strlen($ubigeo_sunat)) {
                                $department_id = $ubigeo[0] ?? null;
                                $province_id   = $ubigeo[1] ?? null;
                                $district_id   = $ubigeo[2] ?? null;
                                $address       = $data['direccion'] ?? '';
                            }
                        } else {
                            $department_id = $ubigeo[0] ?? null;
                            $province_id   = $ubigeo[1] ?? null;
                            $district_id   = $ubigeo[2] ?? null;
                            $address       = $data['direccion'] ?? '';
                        }
                    }

                    $res_data = [
                        'name'          => $data['nombre_o_razon_social'] ?? ($data['razon_social'] ?? ''),
                        'trade_name'    => '',
                        'address'       => $address,
                        'department_id' => $department_id,
                        'province_id'   => $province_id,
                        'district_id'   => $district_id,
                        'condition'     => $data['condicion_de_domicilio'] ?? ($data['condicion'] ?? ''),
                        'state'         => $data['estado_del_contribuyente'] ?? ($data['estado'] ?? ''),
                    ];
                }
                $response['data'] = $res_data;
            }
            $this->saveService(1, $response);
            return $response;
        }

        public function massive_validate_cpe($data)
        {
            $this->parameters['form_params'] = $data;
            $res = $this->client->request('POST', '/api/validacion_multiple_cpe', $this->parameters);
            $this->trackApi->push();
            $this->saveService(2);

            return json_decode($res->getBody()->getContents(), true);
        }

        public function cpe($company_number, $document_type_id, $series, $number, $date_of_issue, $total)
        {
            $form_params = [
                'ruc_emisor' => $company_number,
                'codigo_tipo_documento' => $document_type_id,
                'serie_documento' => $series,
                'numero_documento' => $number,
                'fecha_de_emision' => $date_of_issue,
                'total' => $total
            ];

            $this->parameters['form_params'] = $form_params;
            $res = $this->client->request('POST', '/api/cpe', $this->parameters);
            $this->saveService(3);

            return json_decode($res->getBody()->getContents(), true);
        }

        public function exchange($date)
        {
            $exchange = ExchangeRate::query()->where('date', $date)->first();
            if ($exchange) {
                return [
                    'date' => $date,
                    'purchase' => $exchange->purchase,
                    'sale' => $exchange->sale
                ];
            }

            if ($this->isMigoApi()) {
                // migo.pe: POST /api/v1/exchange con fecha_inicio y fecha_fin en body JSON
                $params = array_merge($this->parameters, [
                    'json' => [
                        'fecha_inicio' => $date,
                        'fecha_fin'    => $date,
                        'token'        => $this->apiToken,
                    ],
                ]);
                $res = $this->client->request('POST', '/api/v1/exchange', $params);
                $response = json_decode($res->getBody()->getContents(), true);

                if (!empty($response['success']) && !empty($response['data'])) {
                    $data = $response['data'][0];
                    ExchangeRate::query()->create([
                        'date'              => $data['fecha'],
                        'date_original'     => $data['fecha'],
                        'sale_original'     => $data['precio_venta'],
                        'sale'              => $data['precio_venta'],
                        'purchase_original' => $data['precio_compra'],
                        'purchase'          => $data['precio_compra'],
                    ]);

                    return [
                        'date'     => $data['fecha'],
                        'purchase' => $data['precio_compra'],
                        'sale'     => $data['precio_venta'],
                    ];
                }
            } else {
                $this->parameters['form_params'] = ['fecha' => $date];
                $res = $this->client->request('POST', '/api/tipo_de_cambio', $this->parameters);
                $response = json_decode($res->getBody()->getContents(), true);

                if ($response['success']) {
                    $data = $response['data'];
                    ExchangeRate::query()->create([
                        'date'              => $data['fecha_busqueda'],
                        'date_original'     => $data['fecha_sunat'],
                        'sale_original'     => $data['venta'],
                        'sale'              => $data['venta'],
                        'purchase_original' => $data['compra'],
                        'purchase'          => $data['compra'],
                    ]);

                    return [
                        'date'     => $data['fecha_busqueda'],
                        'purchase' => $data['compra'],
                        'sale'     => $data['venta'],
                    ];
                }
            }

            $this->saveService(4);

            return [
                'date'     => $date,
                'purchase' => 1,
                'sale'     => 1,
            ];
        }

        public function printer_ticket($data)
        {
            $this->parameters['form_params'] = $data;
            $res = $this->client->request('POST', '/api/printer_ticket', $this->parameters);
            $this->saveService(5);

            return json_decode($res->getBody()->getContents(), true);
        }
    }
