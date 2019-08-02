<?php

use App\User;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of the routes that are handled
| by your application. Just tell Laravel the URIs it should respond
| to using a Closure or controller method. Build something great!
|
*/
Route::get("/webservice", function() {
    // echo 'ocean';die;
    ob_start();
    require(path("webservice")."test.php");
    return ob_get_clean();
});

Route::get('/hello', 'WebserviceController@test');

Route::get('password/reset', 'Auth\ForgotPasswordController@showLinkRequestForm');
Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail');
Route::get('password/reset/{token}', 'Auth\ResetPasswordController@showResetForm');
Route::post('password/reset', 'Auth\ResetPasswordController@reset');
Route::get('subdirect', 'MainController@subdirect');

if (App::environment('local', 'dev', 'testing')) {
    Route::group(
        [
            'prefix' => '/dev',
            'middleware' => [
                'auth.verybasic',
            ]
        ],
        function () {
            Route::get('/users', 'DevController@users');
            Route::get('/user/{uniq_id}', 'DevController@user');
            Route::get('/scanner-toggle/{user_uniq_id}/{project_uniq_id}', 'DevController@scannerToggle');

            Route::get('/clients', 'DevController@clients');
            Route::get('/client/{uniq_id}', 'DevController@client');

            Route::get('/project/{uniq_id}', 'DevController@project');
        }
    );

    Route::get('/dev/swagger.json', 'DevController@swagger'); // no auth
}

// THIS MUST COME LAST
Route::get('/{vue_capture?}', 'MainController@vue')->where('vue_capture', '[\/\w\.-]*');
