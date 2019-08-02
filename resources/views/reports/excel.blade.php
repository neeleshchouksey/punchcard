<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>

        </style>
    </head>
    <body>
        <table>
            <thead>
                @if (isset($reportData['inData']['project']['text']))
                <tr>
                    <td colspan="{{ sizeof($reportData['columns']) }}">
                        <h2>Project : {{ $reportData['inData']['project']['text'] }}</h2>
                    </td>
                </tr>
                @endif

                @if (isset($reportData['inData']['user']['text']))
                <tr>
                    <td colspan="{{ sizeof($reportData['columns']) }}">
                        <h2>User: {{ $reportData['inData']['user']['text'] }}</h2>
                    </td>
                </tr>
                @endif

                @if (isset($reportData['inData']['startDate']))
                <tr>
                    <td colspan="{{ sizeof($reportData['columns']) }}">
                        <h3>Date: {{ $reportData['inData']['startDate'] }} - {{ $reportData['inData']['endDate'] }}</h3>
                    </td>
                </tr>
                @endif

                <tr>
                @foreach ($reportData['columns'] as $col)
                    <td>{{ $col }}</td>
                @endforeach
                </tr>
            </thead>
            <tbody>
            @foreach ($reportData['rows'] as $row)
                <tr>
                    @foreach ($row as $rowTd)
                        <td>{{ $rowTd }}</td>
                    @endforeach
                </tr>
            @endforeach
            </tbody>
        </table>
    </body>
</html>
