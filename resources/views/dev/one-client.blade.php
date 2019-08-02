@extends('dev.layout')
@section('content')

<h1>{{ $client->name }}</h1>

<div>
    <div>
        <label>Uniq ID:</label>
        <div style="display: inline-block;">{{ $client->uniq_id }}</div>
    </div>
    @if ($client->child_of_id != 0)
    <div>
        <label>Child of: </label>
        <div style="display: inline-block;">
            <a href="/dev/client/{{ $client->parent->uniq_id }}">{{ $client->parent->name}}</a>
        </div>
    </div>
    @endif
    <div>
        <label>Login Domain: </label>
        <div style="display: inline-block;">
            <a href="{{ "http://{$client->subdomain}." . env('WILDCARD_DOMAIN') . "/" }}">
                {{ "http://{$client->subdomain}." . env('WILDCARD_DOMAIN') . "/" }}
            </a>
        </div>
    </div>
    <div>
        <label>Status: </label>
        <div style="display: inline-block;">{{ $client->status }}</div>
    </div>
</div>

<div>
    <div style="float: left; width: 40%;">
        <h2>Users in this client</h2>
        <ol>
        @foreach ($client->users as $user)
            <li>
                <a href="/dev/user/{{ $user->uniq_id }}">{{ $user->name }}</a>
                @if ($projectName = $user->is_checked_in)
                    Checked in to {{ $projectName }}
                @endif
                | {{ $user->role }}
                | {{ $user->status }}
            </li>
        @endforeach
        </ol>
    </div>

    @if ($client->child_of_id == 0)
    <div style="float: left; width: 40%;">
        <h2>Projects on this client</h2>
        <ol>
        @foreach ($client->projects as $project)
            <li>
                <a href="/dev/project/{{ $project->uniq_id }}">{{ $project->name }}</a>
                | {{ $project->status }}
            </li>
        @endforeach
        </ol>

        <h2>Children of this client</h2>
        <table id="clients" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <td>Uniq ID</td>
                    <td>ID</td>
                    <td>Name</td>
                    <td>Status</td>
                </tr>
            </thead>
            <tbody>
                @foreach ($client->children as $child)
                <tr>
                    <td><a href="/dev/client/{{ $child->uniq_id }}">{{ $child->uniq_id }}</a></td>
                    <td>{{ $child->id }}</td>
                    <td>{{ $child->name }}</td>
                    <td>{{ $child->status }}</td>
                </tr>
            @endforeach
            </tbody>
        </table>
    </div>
    @endif
</div>
@endsection
