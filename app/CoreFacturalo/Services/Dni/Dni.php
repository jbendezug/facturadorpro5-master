<?php

namespace App\CoreFacturalo\Services\Dni;

class Dni
{
    public static function search($number)
    {
        $res = Migo::search($number);
        if ($res['success']) {
            return $res;
        }

        // Fallback a JNE si Migo falla
        $res = Jne::search($number);
        return $res;
    }
}