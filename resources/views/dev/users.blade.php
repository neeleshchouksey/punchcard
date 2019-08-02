@extends('dev.layout')
@section('content')
    <link href="https://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet" />

    <div class="container" style="width: 90%">
        <table id="users" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <td>Uniq ID</td>
                    <td>ID</td>
                    <td>Client Domain</td>
                    <td>Name</td>
                    <td>Email</td>
                    <td>Mobile Number</td>
                    <td>Role</td>
                    <td>Status</td>
                </tr>
            </thead>
            <tbody>
        @foreach ($users as $user)
            <tr>
                <td><a href="/dev/user/{{ $user->uniq_id }}">{{ $user->uniq_id }}</a></td>
                <td>{{ $user->id }}</td>
                <td>{{ "http://{$user->client->subdomain}." . env('WILDCARD_DOMAIN') . "/api/v1.0/user/" }}</td>
                <td>{{ $user->name }}</td>
                <td>{{ $user->email }}</td>
                <td>{{ $user->mobileNumber }}</td>
                <td>{{ $user->role }}</td>
                <td>{{ $user->status }}</td>
            </tr>
        @endforeach
            </tbody>
        </table>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.js"></script>
    <script>
        $(document).ready(function() {
            $('#users').dataTable();
        });
    </script>
@endsection
