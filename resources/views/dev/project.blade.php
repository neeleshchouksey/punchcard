@extends('dev.layout')
@section('content')
<div>
    <div>
        <h1>{{ $project->name }}</h1>
    </div>

    <div>
        <a href="/dev/client/{{ $project->client->uniq_id }}">{{ $project->client->name }}</a>
    </div>

    <div>
        <label>Date:</label>
        <div style="display: inline-block;">{{ $project->startDate }} - {{ $project->endDate }}</div>
    </div>

    <div>
        <label>UniqId:</label>
        <div style="display: inline-block;">{{ $project->uniq_id }}</div>
    </div>

    <div>
        <label>Status:</label>
        <div style="display: inline-block;">{{ $project->status }}</div>
    </div>

    <div>
        <label>Poly Fence:</label>
        <div style="display: inline-block;">{{ $project->polyfence }}</div>
    </div>
</div>

<h2>Users on Project</h2>

@foreach ($project->users as $user)
    <div>
        <a href="/dev/user/{{ $user->uniq_id }}">{{ $user->name }}</a>
        @if ($projectName = $user->is_checked_in)
            Checked in to {{ $projectName }}
        @else
            Not checked in
        @endif
    </div>
@endforeach
@endsection
