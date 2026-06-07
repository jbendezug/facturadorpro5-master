<?php

namespace Tests\Unit\CoreFacturalo;

use PHPUnit\Framework\TestCase;
use App\CoreFacturalo\Helpers\QrCode\QrCodeGenerate;

class QrCodeGenerateTest extends TestCase
{
    /** @test */
    public function it_generates_qr_code_as_base64_png()
    {
        $qr = new QrCodeGenerate();
        $text = '20123456789|01|F001|00000001|100.00|20240101|1';

        $result = $qr->displayPNGBase64($text);

        $this->assertNotEmpty($result);
        $this->assertIsString($result);
        $this->assertStringEndsNotWith('=', $result);
    }

    /** @test */
    public function it_returns_different_qr_for_different_data()
    {
        $qr = new QrCodeGenerate();
        $result1 = $qr->displayPNGBase64('data1');
        $result2 = $qr->displayPNGBase64('data2');

        $this->assertNotEquals($result1, $result2);
    }
}
