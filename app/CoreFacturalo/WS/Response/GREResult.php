<?php

namespace App\CoreFacturalo\WS\Services;

/**
 * Encapsula la respuesta de la API REST GRE de SUNAT.
 *
 * Equivalente a BillResult pero para el nuevo esquema REST,
 * donde la respuesta es JSON (no CDR/ZIP SOAP).
 */
class GREResult
{
    /** @var bool */
    private $success = false;

    /** @var string */
    private $code = '';

    /** @var string */
    private $description = '';

    /** @var string|null Ticket para consulta asíncrona (si aplica) */
    private $numTicket = null;

    /** @var array Respuesta JSON completa de SUNAT */
    private $rawResponse = [];

    public function isSuccess(): bool
    {
        return $this->success;
    }

    public function setSuccess(bool $success): self
    {
        $this->success = $success;
        return $this;
    }

    public function getCode(): string
    {
        return $this->code;
    }

    public function setCode(string $code): self
    {
        $this->code = $code;
        return $this;
    }

    public function getDescription(): string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;
        return $this;
    }

    public function getNumTicket(): ?string
    {
        return $this->numTicket;
    }

    public function setNumTicket(?string $numTicket): self
    {
        $this->numTicket = $numTicket;
        return $this;
    }

    public function getRawResponse(): array
    {
        return $this->rawResponse;
    }

    public function setRawResponse(array $rawResponse): self
    {
        $this->rawResponse = $rawResponse;
        return $this;
    }

    /**
     * Indica si SUNAT aceptó el documento (código 0 = aceptado).
     */
    public function isAccepted(): bool
    {
        return $this->success && (string)$this->code === '0';
    }

    /**
     * Indica si SUNAT observó el documento (código 2xxx = observación).
     */
    public function isObserved(): bool
    {
        return $this->success && is_numeric($this->code)
            && (int)$this->code >= 2000 && (int)$this->code < 4000;
    }
}
