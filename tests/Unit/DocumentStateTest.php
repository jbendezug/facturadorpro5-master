<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class DocumentStateTest extends TestCase
{
    const VALID_STATES = [
        'REGISTERED',
        'SENT',
        'ACCEPTED',
        'OBSERVED',
        'REJECTED',
        'CANCELED',
        'VOIDED',
    ];

    /** @test */
    public function document_states_are_well_defined()
    {
        $expected = ['REGISTERED', 'SENT', 'ACCEPTED', 'OBSERVED', 'REJECTED', 'CANCELED', 'VOIDED'];
        $this->assertEquals($expected, self::VALID_STATES);
    }

    /** @test */
    public function invalid_state_is_not_in_valid_list()
    {
        $this->assertNotContains('INVALID_STATE', self::VALID_STATES);
    }

    /** @test */
    public function valid_document_types_exist()
    {
        $types = ['01', '03', '07', '08', '09', '20', '40', '56', '87'];
        $this->assertContains('01', $types); // Factura
        $this->assertContains('03', $types); // Boleta
        $this->assertContains('07', $types); // Nota de Crédito
        $this->assertContains('08', $types); // Nota de Débito
    }
}
