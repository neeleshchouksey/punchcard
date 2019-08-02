<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddIsexceptionsToCheck extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('checks', function (Blueprint $table) {
            $table->boolean('isExceptionIn')->default(false);
            $table->boolean('isExceptionOut')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('checks', function (Blueprint $table) {
            $table->dropColumn('isExceptionIn');
            $table->dropColumn('isExceptionOut');
        });
    }
}
