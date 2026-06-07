<?php

namespace Tests\Unit\CoreFacturalo;

use PHPUnit\Framework\TestCase;

class FacturaloTest extends TestCase
{
    /** @test */
    public function facturalo_class_exists()
    {
        $this->assertTrue(class_exists(\App\CoreFacturalo\Facturalo::class));
    }

    /** @test */
    public function core_facturalo_namespace_has_required_classes()
    {
        $classes = [
            \App\CoreFacturalo\Facturalo::class,
            \App\CoreFacturalo\Helpers\Xml\XmlFormat::class,
            \App\CoreFacturalo\Helpers\Xml\XmlHash::class,
            \App\CoreFacturalo\Helpers\QrCode\QrCodeGenerate::class,
            \App\CoreFacturalo\WS\Signed\XmlSigned::class,
        ];

        foreach ($classes as $class) {
            $this->assertTrue(class_exists($class), "Class $class does not exist");
        }
    }
}
