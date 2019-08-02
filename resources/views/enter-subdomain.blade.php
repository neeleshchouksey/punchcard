<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Punchcard</title>

       <!--   <link href="{{ elixir('css/app.css') }}" rel="stylesheet" type="text/css">-->
        <link href="{{ asset(elixir('css/app.css')) }}" rel="stylesheet" type="text/css">
    </head>
    <style type="text/css">
form[action="subdirect"] {
    padding: 15px 15px;
    width: 80%;
    margin: 0px auto;
    background: #fff;
}

form[action="subdirect"] .row .col-sm-8 > div.input-group {
    display: block;
}

form[action="subdirect"] .row .col-sm-8 > div span.input-group-addon:first-child {
    width: 15%;
    display: block;
    float: left;
}

form[action="subdirect"] .row .col-sm-8 > div input.form-control {
    width: 60%;
    float: left;
    margin: 0px;
    box-shadow: none;
    height: 30px;
}

form[action="subdirect"] .row .col-sm-8 > div span.input-group-addon:last-child {
    width: 25%;
    display: block;
    float: left;
}

form[action="subdirect"] .row .col-sm-8, form[action="subdirect"] .row .col-sm-2, form[action="subdirect"] .row .col-sm-1 {
    width: 100%;
    text-align: center;
    margin: 0px auto;
    display: block;
    float: none;
}

form[action="subdirect"] .row .col-sm-3, form[action="subdirect"] .row .col-sm-6 {
    width: 100%;
    text-align: center;
}
    </style>
    <body>

        <form action="subdirect">
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-6">
                    <h1 style="margin: auto;">Enter the subdomain</h1>
                </div>
                <div class="col-sm-3"></div>
            </div>

            <div class="row">
                <div class="col-sm-1"></div>

                <div class="col-sm-8">
                    <div class="input-group">
                        <span class="input-group-addon">{{ env('APP_SCHEME', 'http') }}://</span>
                        <input type="text" class="form-control" name="subdomain" aria-label="Enter subdomain">
                        <span class="input-group-addon">{{ env('WILDCARD_DOMAIN') }}</span>
                    </div>
                </div>

                <div class="col-sm-1">
                    <input type="submit" class="btn primary-button" />
                </div>

                <div class="col-sm-2"></div>
            </div>
        </form>

    </body>
</html>
