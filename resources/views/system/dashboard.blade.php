@extends('system.layouts.app')

@section('content')

    <system-clients-index :delete-permission='@json($delete_permission)'
                          :disc-used='@json($disc_used)'
                          :i-used='@json($i_used)'
                          :storage-size='@json($storage_size)'
                          :version='@json($version)'></system-clients-index>

@endsection
