<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddForeignKeyBetweenUserLogsAndChecks extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_logs', function (Blueprint $table) {

            $table->integer('check_id')->unsigned()->nullable();

            $table->foreign('check_id')
                  ->references('id')->on('checks');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_logs', function (Blueprint $table) {
            $table->dropColumn('check_id');
        });
    }
}
