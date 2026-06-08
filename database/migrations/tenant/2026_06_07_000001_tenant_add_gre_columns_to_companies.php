<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

/**
 * Agrega los campos necesarios para la Guía de Remisión Electrónica (GRE)
 * a la tabla companies del tenant.
 *
 * - use_gre:       habilita el nuevo esquema GRE REST (RS 000123-2022/SUNAT)
 * - gre_client_id: client_id OAuth otorgado por SUNAT SOL
 * - gre_client_secret: client_secret OAuth (se guarda cifrado)
 *
 * IMPORTANTE: gre_client_id y gre_client_secret los otorga SUNAT al
 * registrar la aplicación en el portal SOL. Son distintos al usuario/clave
 * de facturación electrónica normal (soap_username / soap_password).
 */
class TenantAddGreColumnsToCompanies extends Migration
{
    public function up()
    {
        Schema::table('companies', function (Blueprint $table) {
            // Habilitar nuevo esquema GRE (false por defecto = usa esquema SOAP antiguo)
            $table->boolean('use_gre')
                  ->default(false)
                  ->after('send_document_to_pse')
                  ->comment('true = usar nueva API REST GRE (RS 000123-2022)');

            // Credenciales OAuth para GRE
            $table->string('gre_client_id', 100)
                  ->nullable()
                  ->after('use_gre')
                  ->comment('client_id OAuth otorgado por SUNAT SOL para GRE');

            $table->string('gre_client_secret', 200)
                  ->nullable()
                  ->after('gre_client_id')
                  ->comment('client_secret OAuth otorgado por SUNAT SOL para GRE');
        });
    }

    public function down()
    {
        Schema::table('companies', function (Blueprint $table) {
            $table->dropColumn(['use_gre', 'gre_client_id', 'gre_client_secret']);
        });
    }
}
