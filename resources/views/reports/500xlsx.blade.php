<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>

        </style>
    </head>
    <body>
        <h1>{{ $report_number }}: {{ $name }}</h1>

        <table>
            @foreach($reportData['rows'] as $rowProject)
            <tr>
                <td>
                    {{ $rowProject['name'] }}
                </td>
                <td>
                    {{ $rowProject['employeesSum'] }}
                </td>
                <td>
                    {{ $rowProject['hoursSum'] }}
                </td>
                <td>
                    ${{ $rowProject['paySum'] }}
                </td>
            </tr>
            @foreach($rowProject['clients'] as $rowClient)
            <tr>
                <td>
                    &nbsp; {{ $rowClient['name'] }}
                </td>
                <td>
                    {{ $rowClient['employeesSum'] }}
                </td>
                <td>
                    {{ $rowClient['hoursSum'] }}
                </td>
                <td>
                    ${{ $rowClient['paySum'] }}
                </td>
            </tr>
            @foreach($rowClient['users'] as $rowUser)
            <tr>
                <td>
                    &nbsp; {{ $rowUser['name'] }}
                </td>
                <td>
                    {{ $rowUser['uniq_id'] }}
                </td>
                <td>
                    {{ $rowUser['hoursSum'] }}
                </td>
                <td>
                    ${{ $rowUser['paySum'] }}
                </td>
            </tr>
            @foreach($rowUser['checks'] as $rowCheck)
            <tr>
                <td>
                   &nbsp; &nbsp;  {{ $rowCheck['in'] }}
                </td>
                <td>
                    {{ $rowCheck['out'] }}
                </td>
                <td>
                    {{ $rowCheck['hours'] }}
                </td>
                <td>
                    ${{ $rowCheck['pay'] }}
                </td>
            </tr>
            @endforeach
            @endforeach
            @endforeach
            @endforeach
        </table>
    </body>
</html>
