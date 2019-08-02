@extends('dev.layout')
@section('content')
<style>
    body {

        margin: 20px;
        line-height: 28px;
        font-size: 20px;
    }
    label {
        font-weight: bold;
    }

</style>
<h1>{{ $user->name }}</h1>

<h3 style="color: #a00;">
@if ($projectName = $user->is_checked_in)
    Checked in to {{ $projectName }}
@else
    Not checked in
@endif
</h3>

<div>
    <div>
        <label>Uniq ID:</label>
        <div style="display: inline-block;">{{ $user->uniq_id }}</div>
    </div>
    <div>
        <label>Email:</label>
        <div style="display: inline-block;">{{ $user->email }}</div>
    <div>
        <label>Mobile Number:</label>
        <div style="display: inline-block;">{{ $user->mobileNumber }}</div>
    </div>
    <div>
        <label>Username:</label>
        <div style="display: inline-block;">{{ $user->username }}</div>
    </div>

    <div>
        <label>Password:</label>
        <div style="display: inline-block;">abc123456 - if a seeded user, random if created in webapp (respond to email)</div>
    </div>
    <div>
        <label>Role:</label>
        <div style="display: inline-block;">{{ $user->role }}</div>
    </div>
    <div>
        <label>Status: </label>
        <div style="display: inline-block;">{{ $user->status }}</div>
    </div>
    <div>
        <label>Client: </label>
        <div style="display: inline-block;"><a href="/dev/client/{{ $user->client->uniq_id }}">{{ $user->client->name }}</a></div>
    </div>
    <div>
        <label>Domain: </label>
        <div style="display: inline-block;">
            <a href="{{ "http://{$user->client->subdomain}." . env('WILDCARD_DOMAIN') . "/" }}">
                {{ "http://{$user->client->subdomain}." . env('WILDCARD_DOMAIN') . "/" }}
            </a>
        </div>
    </div>
</div>

<h4>Update a User Profile using `PUT` (/api/version/user/)</h4>
<div>
    <!-- note used in PUT "uniq_id": "{{ $user->uniq_id }}", -->
<pre style="padding: 20px; border: 1px solid #aaa;">
{
    "name": "{{ $user->name }}",
    "email": "{{ $user->email }}",
    "mobileNumber": "{{ $user->mobileNumber }}",
    "username": "{{ $user->username }}",
    "jdoc": {{ json_encode($user->jdoc, JSON_PRETTY_PRINT) }}
}
</pre>
</div>

<div>
    <h2>Checking in other users.</h2>

    <p>We now have different endpoints for checking in other users. This was formerly done all at /api/v1.0/user/check.<p>

    <p>
        <div style="margin: 30px;">
            <p>/api/v1.0/check/badge - this is the one known as 'manual'</p>
            <p>/api/v1.0/check/qr - this was called 'qr'</p>

            <p>
                To be able to perform these the User Who is Logged in (who will be
                different than the user being checked in) needs to have <b>Scanner Access</b>.
            </p>

            <p>
                Any user in the company can have scanner access, and they don't have to be on the
                project to be able to scan other people in.
            </p>
        </div>

        <div style="margin: 30px;" id="toggle">
            <p>
                Here is the <b>Scanner Access</b> permissions for this user, {{ $user->name }}:
            <p>

        @foreach ($user->client->projects as $project)
            <div>
                {{ $project->name }}: {!! $user->hasScannerPermission($project->id) ? '<b style="color: #800;">Yes</b>' : 'No' !!}
                (<a href="/dev/scanner-toggle/{{ $user->uniq_id }}/{{ $project->uniq_id}}">toggle</a>)
            </div>
        @endforeach
        </div>

        <div style="margin: 30px;">
            To test these <b>Scanner Access</b> endpoints:
             <ol>
                 <li>
                     find <i> <a href="/dev/client/{{ $user->client->uniq_id }}">a different user in this company</a></i>
                 </li>
                 <li>
                     find a project that user is on
                 </li>
                 <li>
                    come back here, toggle this user to check people in to and out of that project
                 </li>
             </ol>

             <p>
                Try it for various projects, try it without toggle them on (to make sure it <i>doesn't</i> work. Find
                ways to try to break it, and open any issues if you do.
             </p>
        </div>
    </div>
</div>

<div style="width: 700px">
    <h2>Projects this user is on, as a user</h2>
    <h4 style="color: #f55; margin: 20px;">
        <i>
            You should be able to copy and paste these as-is into the appropriate end-point to use and expect to have them
            work. If you find one that does not, please let me know. Also use these as a base, so once you know they work,
            find ways to try to break the system to have it spit out uncaught/500 Internal errors, do wrong things. Be
            creative.
        </i>

        <p>(POST == check-in, PUT == check-out)</p>
    </h4>

    @foreach ($user->projects as $project)
    <?php list($lat, $long) = PolygonParser::random($project->polyfence); ?>
        <div style="margin: 20px 10px 50px 50px;">
            <a href="/dev/project/{{ $project->uniq_id }}">
                <h3>{{ $project->name }}</h3>
            </a>

<h4>Code for SELF (aka {{ '"geo"' }}) check in/out </h4>
<pre style="padding: 20px; border: 3px solid #faa;">
{
   "uniq_id": "{{ $project->uniq_id }}",
   "latitude": "{{ $lat }}",
   "longitude": "{{ $long }}",
   "exceptionReason": null
}

</pre>
<p>(Note: this is the only end point the user can self-check into)</p>

<hr />


<h4>Code for a <i>different user</i> with Scanner Access to check in/out </h4>

<h4>
    Badge (aka 'manual')
</h4>
<pre style="padding: 20px; border: 3px solid #585;">
{
   "uniq_id": "{{ $project->uniq_id }}",
   "badge_id": "{{ $project->badge_id }}",
   "latitude": "{{ $lat }}",
   "longitude": "{{ $long }}"
}
</pre>
<p>(Note: uniq_id is the project the person at the gate typing other people's badge numbers into his phone is looking at)</p>

<hr />

<h4>
    QR Code (aka 'qr')
</h4>
<pre style="padding: 20px; border: 3px solid #55f;">
{
    "viewing_project_uniq_id": "{{ $project->uniq_id }}",
    "qr_provided_project_uniq_id": "{{ $project->uniq_id }}",
    "qr_provided_user_uniq_id": "{{ $user->uniq_id }}",
    "latitude": "{{ $lat }}",
    "longitude": "{{ $long }}"
}
</pre>

<p>
    (Note: viewing_project_uniq_id is the project the person at the gate scanning other people's badges is looking at in his
    app; the other two come from the QR Code itself. They are not named that in the QR Code (behind the scenes) as a little
    more security since people can scan their own badge and see this information if they wanted)
</p>

<hr />

            <div style="margin-left: 15px; font-size: 16px;">
                Note: these are the points in the polygon. Choose any set and you can rely that it will be valid, and test 'outside' of the points to test that invalid points are outside the fence.
                <div>
                    {{ $project->polyfence }}
                </div>
            </div>

        </div>
    @endforeach
</div>
@endsection
