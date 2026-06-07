<?php

namespace Tests\Unit\CoreFacturalo;

use PHPUnit\Framework\TestCase;
use App\CoreFacturalo\WS\Signed\XmlSigned;

class XmlSignedTest extends TestCase
{
    /** @test */
    public function xml_signed_class_exists()
    {
        $this->assertTrue(class_exists(XmlSigned::class));
    }

    /** @test */
    public function it_can_be_instantiated()
    {
        $signer = new XmlSigned();
        $this->assertInstanceOf(XmlSigned::class, $signer);
    }
}
