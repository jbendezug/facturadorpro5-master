<?php

namespace App\Http\Requests\Tenant;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CompanyRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $id = $this->input('id');
        return [
            'name' => [
                'required',
                Rule::unique('tenant.companies')->ignore($id),
            ],
            'trade_name' => [
                'required',
                Rule::unique('tenant.companies')->ignore($id),
            ],
            'number' => [
                'required',
                Rule::unique('tenant.companies')->ignore($id),
            ],
            'soap_type_id' => [
                'nullable'
            ],
            'soap_username' => [
                'required_if:soap_type_id,"02"',
                'required_if:soap_send_id,"02"'
            ],
            'soap_password' => [
                'required_if:soap_type_id,"02"',
                'required_if:soap_send_id,"02"'
            ],
            // GRE - Guía de Remisión Electrónica (nueva API REST)
            'use_gre' => [
                'nullable',
                'boolean'
            ],
            'gre_client_id' => [
                'required_if:use_gre,true',
                'nullable',
                'string',
                'max:100'
            ],
            'gre_client_secret' => [
                'required_if:use_gre,true',
                'nullable',
                'string',
                'max:200'
            ],
        ];
    }

    public function messages()
    {
        return [
            'gre_client_id.required_if' => 'El Client ID de GRE es obligatorio cuando habilitas el esquema GRE.',
            'gre_client_secret.required_if' => 'El Client Secret de GRE es obligatorio cuando habilitas el esquema GRE.',
        ];
    }
}
