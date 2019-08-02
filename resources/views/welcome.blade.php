<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Punchcard</title>

        <link href="{{ asset(elixir('css/app.css')) }}" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="app"><app></app></div>

        <script>
            window.DevConfig = {"mode": 'history', "hash": '', "home": '/', "url": '/'}
//
// Fixes an IE issue
//

if (typeof Object.assign != 'function') {
    Object.assign = function(target) {
        'use strict';

        if (target == null) {
            throw new TypeError('Cannot convert undefined or null to object');
        }

        target = Object(target);
        for (var index = 1; index < arguments.length; index++) {
            var source = arguments[index];

            if (source != null) {
                    for (var key in source) {
                        if (Object.prototype.hasOwnProperty.call(source, key)) {
                            target[key] = source[key];
                    }
                }
            }
        }

        return target;
    };
}

        </script>
        <script src="https://use.fontawesome.com/2ed3a0928f.js"></script>
        <script src="{{ asset(elixir('js/app.js')) }}"></script>
    </body>
</html>
