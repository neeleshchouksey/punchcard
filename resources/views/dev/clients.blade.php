@extends('dev.layout')
@section('content')

    <div class="container" style="width: 90%">
        <table id="clients" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <td>Uniq ID</td>
                    <td>ID</td>
                    <td>Login Client Domain</td>
                    <td>Name</td>
                    <td>Status</td>
                </tr>
            </thead>
            <tbody>
            @foreach ($clients as $client)
                <tr>
                    <td><a href="/dev/client/{{ $client->uniq_id }}">{{ $client->uniq_id }}</a></td>
                    <td>{{ $client->id }}</td>
                    <td class="{{ empty($client->child_of_id) ? 'bold' : '' }}">{{ "http://{$client->subdomain}." . env('WILDCARD_DOMAIN') . "/" }}</td>
                    <td>{{ $client->name }}</td>
                    <td>{{ $client->status }}</td>
                </tr>
            @endforeach
            </tbody>
        </table>
    </div>

@endsection
