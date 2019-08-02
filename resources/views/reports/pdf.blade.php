<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

        <title>Punchcard</title>

        <link rel="stylesheet" href="{{ ltrim(elixir('css/app.css'), '/') }}" />
        <style>
            .page-break {
                page-break-after: always;
            }
        </style>
    </head>
    <body>
        <h2>
            {{ $report_number }}
            {{ $name }}
        </h2>

        @if (isset($reportData['inData']['client']['text']))
            <h3>Client: {{ $reportData['inData']['client']['text'] }}</h3>
        @endif

        @if (isset($reportData['inData']['project']['text']))
            <h3>Project : {{ $reportData['inData']['project']['text'] }}</h3>
        @endif

        @if (isset($reportData['inData']['user']['text']))
            <h3>User: {{ $reportData['inData']['user']['text'] }}</h3>
        @endif

        @if (isset($reportData['inData']['startDate']))
            <h3>Date: {{ $reportData['inData']['startDate'] }} - {{ $reportData['inData']['endDate'] }}</h3>
        @endif

        {!! $html !!}
    </body>
</html>
