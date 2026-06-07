<?php

namespace Tests\Unit\CoreFacturalo;

use PHPUnit\Framework\TestCase;
use App\CoreFacturalo\Helpers\Xml\XmlFormat;
use App\CoreFacturalo\Helpers\Xml\XmlHash;

class XmlFormatTest extends TestCase
{
    /** @test */
    public function it_formats_xml_string()
    {
        $xml = '<?xml version="1.0" encoding="UTF-8"?><root><item id="1">test</item></root>';
        $formatted = XmlFormat::format($xml);

        $this->assertStringContainsString('<?xml version="1.0"', $formatted);
        $this->assertStringContainsString('<root>', $formatted);
        $this->assertStringContainsString('<item id="1">', $formatted);
    }

    /** @test */
    public function xml_hash_class_exists()
    {
        $this->assertTrue(class_exists(XmlHash::class));
    }

    /** @test */
    public function xml_hash_can_be_instantiated()
    {
        $xmlHash = new XmlHash();
        $this->assertInstanceOf(XmlHash::class, $xmlHash);
    }
}
