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
                <tr>
                @foreach ($columns as $col)
                    <td>{{ $col }}</td>
                @endforeach
                </tr>
            </thead>
            <tbody>
            @foreach ($rows as $row)
                <tr>
                    @foreach ($row as $key => $rowTd)
                        @if(is_array($rowTd))
                            @continue;
                        @endif

                        <td>{{ $rowTd }}</td>
                    @endforeach
                </tr>
            @endforeach
            </tbody>
        </table>
    </body>
</html>
