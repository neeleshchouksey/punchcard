<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Ramsey\Uuid\Uuid;

class InsertRecords extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $client_id = DB::table('clients')->insert(
            [
                'name' => 'IHOS',
                'fein' => '11111111',
                'status' => 'active',
                'uniq_id' => Uuid::Uuid4(),
                'subdomain' => 'ihos',
            ]
        );

        $user = DB::table('users')->insert(
            [
                'client_id' => $client_id,
                'first_name' => 'IHOS',
                'last_name' => 'Superadmin',
                'uniq_id' => Uuid::Uuid4(),
                'email' => 'ihos@inverseapp.today',
                'mobileNumber' => '555-555-1212',
                'status' => 'active',
                'role' => 'superadmin',
                'username' => 'ihosSuperadmin',
                'password' => bcrypt('abc123456')
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'd2cb6670-dc30-48f5-b3c3-662b2fe4ce72',
            'report_number' => 'RPT-500',
            'name' => 'Estimated Payroll',
            'permissions' => '{"user": false, "superuser": false, "admin": false, "clientadmin": true, "superadmin": false}'
            ]
        );





        DB::table('reports')->insert([
            'uniq_id' => '029bb68b-6b1e-434f-aee0-309e982ba338',
            'report_number' => 'RPT-100',
            'name' => 'Client Summary',
            'permissions' => '{"user": false, "superuser": false, "admin": false, "clientadmin": false, "superadmin": true }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'ce995ad8-a9cc-4b0c-984d-2328efef0ffe',
            'report_number' => 'RPT-101',
            'name' => 'Client Detail',
            'permissions' => '{"user": false, "superuser": false, "admin": false, "clientadmin": false, "superadmin": true }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'cda523e7-dcdf-446f-903e-6359b32d0837',
            'report_number' => 'RPT-200',
            'name' => 'Company Summary',
            'permissions' => '{"user": false, "superuser": false, "admin": true, "clientadmin": true, "superadmin": true }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => '0c397f5b-0c6c-4886-b90e-7b9811579133',
            'report_number' => 'RPT-201',
            'name' => 'Company Detail',
            'permissions' => '{"user": false, "superuser": false, "admin": true, "clientadmin": true, "superadmin": true }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => '0d7bd1c0-d7be-4795-bc1a-26ca793ee681',
            'report_number' => 'RPT-300',
            'name' => 'Project Hours Summary',
            'permissions' => '{"user": false, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'b5a446ab-e5c1-467b-8d0b-208c96e15d9c',
            'report_number' => 'RPT-301',
            'name' => 'Project Hours Detail',
            'permissions' => '{"user": false, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => '212da9b3-27cb-4772-afe0-cd62aed45b32',
            'report_number' => 'RPT-302',
            'name' => 'Project Employees Onsite',
            'permissions' => '{"user": false, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        /* per Matt on slack, remove
        DB::table('reports')->insert([
            'uniq_id' => 'df97f9c2-2a01-496f-90ff-d19acdd5bb74',
            'report_number' => 'RPT-303',
            'name' => 'Project Tasks',
            'permissions' => '{"user": false, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );
         */

        DB::table('reports')->insert([
            'uniq_id' => '7ac2ca43-080c-4b7d-98c5-5131d029039b',
            'report_number' => 'RPT-400',
            'name' => 'Employee Timesheet',
            'permissions' => '{"user": true, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'a9645c43-9f7c-4e3a-8a1d-c12dee405d17',
            'report_number' => 'RPT-401',
            'name' => 'Employee Punches',
            'permissions' => '{"user": true, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'f4bfcb9c-58e2-4425-b405-1f81d96bf292',
            'report_number' => 'RPT-402',
            'name' => 'Employee Detail',
            'permissions' => '{"user": true, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'da82c56e-946c-47b1-a140-32e17a1a443e',
            'report_number' => 'RPT-403',
            'name' => 'Employee Late',
            'permissions' => '{"user": true, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'b5fdba37-5472-4d55-a539-f4927f048677',
            'report_number' => 'RPT-404',
            'name' => 'Employee Overtime',
            'permissions' => '{"user": true, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('reports')->insert([
            'uniq_id' => 'bca9c450-7a41-44e8-b38a-1e34cf25dafc',
            'report_number' => 'RPT-405',
            'name' => 'Employee geo-fence',
            'permissions' => '{"user": true, "superuser": true, "admin": true, "clientadmin": true, "superadmin": false }'
            ]
        );

        DB::table('oauth_clients')->insert([
            'id' => 1,
            'name' => 'Punchcard Webapp',
            'secret' => 'w1kReIyXz09b6BmPleS9bIpHDUwfqdWBrUKJww5R',
            'redirect' => 'https://punchcardllc.com/',
            'personal_access_client' => 'f',
            'password_client' => 't',
            'revoked' => 'f'
            ]
        );

        DB::table('oauth_clients')->insert([
            'id' => 2,
            'name' => 'Punchcard iOS',
            'secret' => 'yhrgpwQBdIpOYnVmAj2OeStyuTzLcvBRWnwVwpUM',
            'redirect' => 'https://punchcardllc.com/',
            'personal_access_client' => 'f',
            'password_client' => 't',
            'revoked' => 'f'
            ]
        );

        DB::table('oauth_clients')->insert([
            'id' => 3,
            'name' => 'Punchcard Android',
            'secret' => 'HkZA9toqv6tGfeMcOV9Hzk05bvUGwiW8jpdAislP',
            'redirect' => 'https://punchcardllc.com/',
            'personal_access_client' => 'f',
            'password_client' => 't',
            'revoked' => 'f'
            ]
        );

        DB::table('oauth_clients')->insert([
            'id' => 4,
            'name' => 'Punchcard Impersonate',
            'secret' => 'Pk3zLc0fjiJEbxXIbhkYvnV2YbJRWwd6mfPa9jlu',
            'redirect' => 'https://punchcardllc.com/',
            'personal_access_client' => 't',
            'password_client' => 'f',
            'revoked' => 'f'
            ]
        );

        DB::table('sectors')->insert(['name' => 'Sector']);
        DB::table('industries')->insert(['name' => 'Industry']);

        DB::table('oauth_personal_access_clients')->insert([
            'client_id' => 4
        ]);

        echo " #####################################################" . PHP_EOL;
        echo " # BE SURE TO REINDEX SCOUT IN HOMESTEAD             #" . PHP_EOL;
        echo " # php artisan scout:flush App\\SearchProjectsUsers  #" . PHP_EOL;
        echo " # php artisan scout:import App\\SearchProjectsUsers #" . PHP_EOL;
        echo " #####################################################" . PHP_EOL;

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
    }
}
