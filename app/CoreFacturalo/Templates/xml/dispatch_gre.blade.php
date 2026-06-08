{{--
    Template XML Guía de Remisión Remitente Electrónica — GRE v2.0
    Resolución de Superintendencia N° 000123-2022/SUNAT
    CustomizationID: 2.0  |  UBLVersionID: 2.1

    DIFERENCIAS con dispatch.blade.php (versión antigua 1.0):
    - Namespace principal: urn:sunat:names:specification:ubl:peru:schema:xsd:Waybill-1
    - CustomizationID: 2.0 (antes 1.0)
    - Se elimina DespatchAdvice, se usa Waybill
    - Conductor y vehículo se informan dentro de ShipmentStage con nuevas reglas
    - Múltiples destinos soportados
    - Datos del transportista expandidos (MTC)

    NOTA: El XML generado se envía via API REST (GREClient), NO via SOAP (WsClient).
--}}
@php
    $dispatch = $document;
@endphp
{!! '<?xml version="1.0" encoding="utf-8" standalone="no"?>' !!}
<Waybill xmlns="urn:sunat:names:specification:ubl:peru:schema:xsd:Waybill-1"
         xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
         xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
         xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
         xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
         xmlns:sac="urn:sunat:names:specification:ubl:peru:schema:xsd:SunatAggregateComponents-1">

    <ext:UBLExtensions>
        <ext:UBLExtension>
            <ext:ExtensionContent/>
        </ext:UBLExtension>
    </ext:UBLExtensions>

    <cbc:UBLVersionID>2.1</cbc:UBLVersionID>
    <cbc:CustomizationID>2.0</cbc:CustomizationID>

    <cbc:ID>{{ $document->series }}-{{ $document->number }}</cbc:ID>
    <cbc:IssueDate>{{ $document->date_of_issue->format('Y-m-d') }}</cbc:IssueDate>
    <cbc:IssueTime>{{ $document->time_of_issue }}</cbc:IssueTime>
    <cbc:DespatchAdviceTypeCode listAgencyName="PE:SUNAT"
                                listName="Tipo de Documento"
                                listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01">{{ $document->document_type_id }}</cbc:DespatchAdviceTypeCode>

    @if($document->observations)
    <cbc:Note><![CDATA[{{ $document->observations }}]]></cbc:Note>
    @endif

    {{-- Documento relacionado (factura, boleta, etc.) --}}
    @if($document->related)
    <cac:AdditionalDocumentReference>
        <cbc:ID>{{ $document->related->number }}</cbc:ID>
        <cbc:DocumentTypeCode
            listAgencyName="PE:SUNAT"
            listName="Tipo de Documento"
            listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01">{{ $document->related->document_type_id }}</cbc:DocumentTypeCode>
    </cac:AdditionalDocumentReference>
    @endif

    {{-- Firma digital --}}
    <cac:Signature>
        <cbc:ID>{{ config('configuration.signature_uri') }}</cbc:ID>
        <cbc:Note>{{ config('configuration.signature_note') }}</cbc:Note>
        <cac:SignatoryParty>
            <cac:PartyIdentification>
                <cbc:ID>{{ $company->number }}</cbc:ID>
            </cac:PartyIdentification>
            <cac:PartyName>
                <cbc:Name><![CDATA[{{ $company->trade_name }}]]></cbc:Name>
            </cac:PartyName>
        </cac:SignatoryParty>
        <cac:DigitalSignatureAttachment>
            <cac:ExternalReference>
                <cbc:URI>#{{ config('configuration.signature_uri') }}</cbc:URI>
            </cac:ExternalReference>
        </cac:DigitalSignatureAttachment>
    </cac:Signature>

    {{-- Remitente (empresa emisora) --}}
    <cac:DespatchSupplierParty>
        <cbc:CustomerAssignedAccountID schemeID="6">{{ $company->number }}</cbc:CustomerAssignedAccountID>
        <cac:Party>
            <cac:PartyLegalEntity>
                <cbc:RegistrationName><![CDATA[{{ $company->name }}]]></cbc:RegistrationName>
                <cac:RegistrationAddress>
                    <cbc:ID>{{ $establishment->district_id }}</cbc:ID>
                    <cbc:AddressTypeCode>{{ $establishment->code }}</cbc:AddressTypeCode>
                    @if($establishment->urbanization)
                    <cbc:CitySubdivisionName>{{ $establishment->urbanization }}</cbc:CitySubdivisionName>
                    @endif
                    <cbc:CityName>{{ $establishment->province->description }}</cbc:CityName>
                    <cbc:CountrySubentity>{{ $establishment->department->description }}</cbc:CountrySubentity>
                    <cbc:District>{{ $establishment->district->description }}</cbc:District>
                    @if($establishment->address && $establishment->address !== '-')
                    <cac:AddressLine>
                        <cbc:Line><![CDATA[{{ $establishment->address }}]]></cbc:Line>
                    </cac:AddressLine>
                    @endif
                    <cac:Country>
                        <cbc:IdentificationCode>PE</cbc:IdentificationCode>
                    </cac:Country>
                </cac:RegistrationAddress>
            </cac:PartyLegalEntity>
        </cac:Party>
    </cac:DespatchSupplierParty>

    {{-- Destinatario --}}
    <cac:DeliveryCustomerParty>
        <cbc:CustomerAssignedAccountID schemeID="{{ $document->customer->identity_document_type_id }}">{{ $document->customer->number }}</cbc:CustomerAssignedAccountID>
        <cac:Party>
            <cac:PartyLegalEntity>
                <cbc:RegistrationName><![CDATA[{{ $document->customer->name }}]]></cbc:RegistrationName>
            </cac:PartyLegalEntity>
        </cac:Party>
    </cac:DeliveryCustomerParty>

    {{-- Datos del envío --}}
    <cac:Shipment>
        <cbc:ID>1</cbc:ID>

        {{-- Motivo de traslado (catálogo 20) --}}
        <cbc:HandlingCode
            listAgencyName="PE:SUNAT"
            listName="Motivo de traslado"
            listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo20">{{ $document->transfer_reason_type_id }}</cbc:HandlingCode>

        @if($document->transfer_reason_description)
        <cbc:Information>{{ $document->transfer_reason_description }}</cbc:Information>
        @endif

        {{-- Peso bruto total --}}
        <cbc:GrossWeightMeasure unitCode="{{ $document->unit_type_id }}">{{ $document->total_weight }}</cbc:GrossWeightMeasure>

        @if($document->packages_number)
        <cbc:TotalTransportHandlingUnitQuantity>{{ $document->packages_number }}</cbc:TotalTransportHandlingUnitQuantity>
        @endif

        {{-- Indicador de transbordo --}}
        <cbc:SplitConsignmentIndicator>{{ $document->transshipment_indicator ? 'true' : 'false' }}</cbc:SplitConsignmentIndicator>

        <cac:ShipmentStage>
            {{-- Modalidad de traslado (catálogo 18): 01=Público, 02=Privado --}}
            <cbc:TransportModeCode
                listAgencyName="PE:SUNAT"
                listName="Modalidad de traslado"
                listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo18">{{ $document->transport_mode_type_id }}</cbc:TransportModeCode>

            <cac:TransitPeriod>
                <cbc:StartDate>{{ $document->date_of_shipping->format('Y-m-d') }}</cbc:StartDate>
            </cac:TransitPeriod>

            {{-- Transportista (solo en modalidad pública) --}}
            @if($document->dispatcher && $document->transport_mode_type_id === '01')
            @php($dispatcher = $document->dispatcher)
            <cac:CarrierParty>
                <cac:PartyIdentification>
                    <cbc:ID schemeID="{{ $dispatcher->identity_document_type_id }}">{{ $dispatcher->number }}</cbc:ID>
                </cac:PartyIdentification>
                <cac:PartyName>
                    <cbc:Name><![CDATA[{{ $dispatcher->name }}]]></cbc:Name>
                </cac:PartyName>
                <cac:PartyLegalEntity>
                    <cbc:RegistrationName><![CDATA[{{ $dispatcher->name }}]]></cbc:RegistrationName>
                </cac:PartyLegalEntity>
            </cac:CarrierParty>
            @endif

            {{-- Vehículo principal --}}
            @if($document->license_plate)
            <cac:TransportMeans>
                <cac:RoadTransport>
                    <cbc:LicensePlateID>{{ $document->license_plate }}</cbc:LicensePlateID>
                </cac:RoadTransport>
            </cac:TransportMeans>
            @endif

            {{-- Conductor --}}
            @if($document->driver)
            @php($driver = $document->driver)
            @if(!is_null($driver->identity_document_type_id) && !is_null($driver->number))
            <cac:DriverPerson>
                <cbc:ID schemeID="{{ $driver->identity_document_type_id }}">{{ $driver->number }}</cbc:ID>
            </cac:DriverPerson>
            @endif
            @endif
        </cac:ShipmentStage>

        {{-- Dirección de entrega --}}
        <cac:Delivery>
            <cac:DeliveryAddress>
                <cbc:ID>{{ $document->delivery->location_id }}</cbc:ID>
                <cbc:StreetName><![CDATA[{{ $document->delivery->address }}]]></cbc:StreetName>
                <cac:Country>
                    <cbc:IdentificationCode>PE</cbc:IdentificationCode>
                </cac:Country>
            </cac:DeliveryAddress>
        </cac:Delivery>

        {{-- Contenedor (si aplica) --}}
        @if($document->container_number)
        <cac:TransportHandlingUnit>
            <cbc:ID>{{ $document->container_number }}</cbc:ID>
        </cac:TransportHandlingUnit>
        @endif

        {{-- Semirremolque (si aplica) --}}
        @if($document->secondary_license_plates && $document->secondary_license_plates->semitrailer)
        <cac:TransportHandlingUnit>
            <cbc:ID>{{ $document->license_plate }}</cbc:ID>
            <cac:TransportEquipment>
                <cbc:ID>{{ $document->secondary_license_plates->semitrailer }}</cbc:ID>
            </cac:TransportEquipment>
        </cac:TransportHandlingUnit>
        @endif

        {{-- Dirección de origen --}}
        <cac:OriginAddress>
            <cbc:ID>{{ $document->origin->location_id }}</cbc:ID>
            <cbc:StreetName><![CDATA[{{ $document->origin->address }}]]></cbc:StreetName>
            <cac:Country>
                <cbc:IdentificationCode>PE</cbc:IdentificationCode>
            </cac:Country>
        </cac:OriginAddress>

        @if($document->port_code)
        <cac:FirstArrivalPortLocation>
            <cbc:ID>{{ $document->port_code }}</cbc:ID>
        </cac:FirstArrivalPortLocation>
        @endif

    </cac:Shipment>

    {{-- Líneas de detalle --}}
    @foreach($document->items as $row)
    <cac:DespatchLine>
        <cbc:ID>{{ $loop->iteration }}</cbc:ID>
        <cbc:DeliveredQuantity unitCode="{{ $row->item->unit_type_id }}">{{ $row->quantity }}</cbc:DeliveredQuantity>
        <cac:OrderLineReference>
            <cbc:LineID>{{ $loop->iteration }}</cbc:LineID>
        </cac:OrderLineReference>
        <cac:Item>
            <cbc:Name><![CDATA[{{ $row->item->description }}]]></cbc:Name>
            <cac:SellersItemIdentification>
                <cbc:ID>{{ $row->item->internal_id }}</cbc:ID>
            </cac:SellersItemIdentification>
            @if($row->item->item_code)
            <cac:CommodityClassification>
                <cbc:ItemClassificationCode
                    listID="UNSPSC"
                    listAgencyName="GS1 US"
                    listName="Item Classification">{{ $row->item->item_code }}</cbc:ItemClassificationCode>
            </cac:CommodityClassification>
            @endif
        </cac:Item>
    </cac:DespatchLine>
    @endforeach

</Waybill>
