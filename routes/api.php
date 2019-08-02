<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

#Route::get('/', 'MainController@index');

//
// Most Logos can't rely on an auth user's subdomain
// Do not add auth here
//

// UPDATE clients SET "creditCardDeactivateDate" = '2018-01-22' WHERE id = 88

// update users set
//   jdoc = jsonb_set(jdoc, '{scheduling}', jdoc->'scheduling' || ' {
//                 "payPeriod": "weekly",
//                 "paySchedule": "hourly",
//                 "dailyEndTime": "16:00",
//                 "workWeekStart": "monday",
//                 "dailyStartTime": "07:00",
//                 "lunchTimeAmount": "60"
//             }')
// Route::get('ocean', 'ClientsController@ocean');

Route::get("/webservice", function() {
    // echo 'ocean';die;
    ob_start();
    require(path("webservice")."test.php");
    return ob_get_clean();
});
Route::group(
    [
        'prefix' => '/crons'
        
    ],
    function () {
        Route::get('/checkTrialExpire', 'PlansController@checkTrial');
        Route::post('/punchcardupgrade', 'PlansController@PunchUpDown');
        Route::post('/punchcardSubscription', 'PlansController@detailsEnter');
        Route::post('/punchcardUnsubscribe', 'PlansController@unsubscribe');
        Route::get('/billingEveryMonth', 'PlansController@billing_cycle');
        Route::get('/checkCC', 'PlansController@creditCardVerify');
        Route::get('/ccExpiredMail', 'PlansController@ccExpiredMail');
        Route::get('/notificationEmailBeforeTrial', 'PlansController@emailtrial');
        Route::post('/punch_history', 'PlansController@punchHistory');
        Route::post('/updateCC', 'PlansController@updateCard');
        Route::post('/currentMonthPunch', 'PlansController@currentMonthPunch');
        Route::post('/download_txnHistory',"PlansController@downloadPDF");
        Route::get('/weather',"PlansController@weatherApi");
        // Route::post('/companiesCurrentlyOnSite',"PlansController@companiesCurrentlyOnSite");

    }
);

Route::get('/v1.0/clients/logo/{uniq_id?}', 'ClientsController@getLogo');
Route::get('/v1.0/projects/{uniq_id}/logo', 'ProjectsController@logo');// ->middleware('authorize.at_least:admin');
Route::post('/v1.0/oauth/token', '\Laravel\Passport\Http\Controllers\AccessTokenController@issueToken');
Route::get('/v1.0/user/avatar/{uniq_id}', 'UserController@getAvatar');

Route::group(
    [
        'prefix' => '/v1.0/webapp',
        'middleware' => [
            'auth:api',
            'authorize.at_least:superuser'
        ]
    ],
    function () {
        Route::post('/data-imports/users', 'DataImportController@users')->middleware('authorize.at_least:admin');
        Route::post('/data-imports/clients', 'DataImportController@clients')->middleware('authorize.at_least:admin');
        Route::post('/data-imports/projects', 'DataImportController@projects')->middleware('authorize.at_least:admin');
        Route::post('/data-imports/checks', 'DataImportController@checks')->middleware('authorize.at_least:admin');
        Route::post('/data-exports/excel', 'DataExportController@excel')->middleware('authorize.at_least:superuser');
        Route::post('/data-exports/pdf', 'DataExportController@pdf')->middleware('authorize.at_least:superuser');
        Route::post('/data-exports/csv', 'DataExportController@csv')->middleware('authorize.at_least:superuser');
        Route::get('/data-exports/bulk', 'DataExportController@bulk')->middleware('authorize.at_least:admin');

        Route::post('/check/scanner/toggle', 'CheckController@scannerToggle');
         Route::get('/clients/{uniq_id?}', 'ClientsWebappController@index')->middleware('authorize.at_least:admin');
         Route::put('/client-logo/', 'ClientsWebappController@putLogo');
         Route::put('/clients/', 'ClientsWebappController@put')->middleware('authorize.at_least:admin');
        Route::post('/clients/', 'ClientsWebappController@post')->middleware('authorize.at_least:clientadmin');
        Route::post('/clients/parent', 'ClientsWebappController@postParent')->middleware('authorize.at_least:superadmin');
        Route::post('/clients/contact', 'ClientsWebappController@addContact')->middleware('authorize.at_least:admin');
        Route::put('/clients/contact', 'ClientsWebappController@removeContact')->middleware('authorize.at_least:admin'); // <- delete but needed payload
         Route::delete('/clients/{uniq_id}', 'ClientsWebappController@delete');

         Route::get('/project-users/{uniq_id}', 'ProjectsAdminController@users');
         Route::get('/project-users/{uniq_id}/staffed', 'ProjectsAdminController@usersStaffed');
         Route::put('/project-users', 'ProjectsAdminController@putRemoveUser');
         Route::post('/project-users', 'ProjectsAdminController@postAddUser');
         Route::post('/addAllChildUsers', 'ProjectsAdminController@addAllChildUsers');

         Route::get('/project-clients/{uniq_id}', 'ProjectsAdminController@clients');
         Route::put('/project-clients', 'ProjectsAdminController@putRemoveClient');
         Route::post('/project-clients', 'ProjectsAdminController@postAddClient');
         Route::put('/project-logo/', 'ProjectsAdminController@putLogo');
         Route::get('/projects/{uniq_id?}', 'ProjectsAdminController@index');
         Route::delete('/projects/{uniq_id}', 'ProjectsAdminController@delete');
         Route::put('/projects/', 'ProjectsAdminController@put');
         Route::post('/projects/', 'ProjectsAdminController@post');

         Route::get('/user/{uniq_id?}', 'UserWebappController@profile');

         Route::delete('/users/{uniq_id}', 'UserWebappController@deleteUser');
         Route::put('/users', 'UserWebappController@putUser');
         Route::post('/users', 'UserWebappController@postUser');
         Route::put('/user-avatar', 'UserWebappController@putAvatar');

         Route::get('/users/{uniq_id?}', 'UserWebappController@view');
         Route::get('/users/{uniq_id}/timesheets', 'UserWebappController@timesheets');
         Route::put('/users/{uniq_id}/timesheets', 'UserWebappController@saveTimesheet');

        Route::post('/check/badge', 'CheckBadgeWebappController@post');
        Route::put('/check/badge', 'CheckBadgeWebappController@put');

         Route::get('/allreports', 'ReportsWebappController@all');
         Route::get('/reports/{uniq_id?}', 'ReportsWebappController@index');
        Route::post('/reports/toggle', 'ReportsWebappController@toggle');
         Route::get('/reporting/option-data/{uniq_id}', 'ReportsWebappController@optionData');
         Route::get('/reporting/{uniq_id?}', 'ReportsWebappController@reportData');

        Route::post('/imp', 'ImpersonateUserController@index');
        /*For previous and present punchas list @PALASH*/
        //Route::post('/punch_history/', 'PlansController@punchHistory')->middleware('authorize.at_least:clientadmin');
        Route::post('/employeesCurrentlyOnSite/', 'PlansController@employeesCurrentlyOnSite');
        Route::post('/companiesCurrentlyOnSite',"PlansController@companiesCurrentlyOnSite");
    }
);

Route::group(
    [
        'prefix' => '/v1.0',
        'middleware' => [
            'auth:api',
            'authorize.at_least:user'
        ]
    ],
    function () {
        Route::get('/', 'MainController@index');
        Route::get('/hello', 'WebserviceController@test');
        // Route::get('/', function(){
        //     echo "hello";
        // });
        Route::get('/search/projects/{uniq_id}', 'SearchController@projects');
        Route::get('/user', 'UserController@profile');
        Route::get('/user/logs', 'UserController@logs');

        Route::post('/user/logs', 'UserController@postLog');
        Route::put('/user', 'UserController@putProfile');
        Route::get('/user/avatar', 'UserController@getAvatar');
        Route::put('/user/avatar', 'UserController@putAvatar');

        Route::get('/user/qr/{user_uniq_id}/{project_uniq_id}', 'UserController@qr');
        Route::get('/user/badge/{user_uniq_id}/{project_uniq_id}', 'UserController@badge');

        Route::get('/projects/{uniq_id?}', 'ProjectsController@index');

        Route::get('/user/checkins', 'UserCheckController@checkInList');
        Route::get('/user/check', 'UserCheckController@get');

        Route::post('/user/check', 'UserCheckController@post');
        Route::put('/user/check', 'UserCheckController@put');

        Route::post('/check/badge', 'CheckBadgeController@post');
        Route::put('/check/badge', 'CheckBadgeController@put');

        Route::post('/check/qr', 'CheckQrController@post');
        Route::put('/check/qr', 'CheckQrController@put');

        
        Route::post('/check/face', 'CheckFaceController@post');
        Route::put('/check/face', 'CheckFaceController@put');

        Route::put('/user/password', 'PasswordChangeController@put');

        Route::get('/employee/{uniq_id}', 'EmployeeController@get');
        #Route::get('/projects/{uniq_id}/onsite', 'ProjectsController@onsite')->middleware('authorize.at_least:superuser');
        Route::get('/projects/{uniq_id}/logs', 'ProjectsController@logs')->middleware('authorize.at_least:user');
        Route::get('/projects/{uniq_id}/employees', 'ProjectsController@employees')->middleware('authorize.at_least:superuser');
    }
);
