<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddAddressFieldsToProject extends Migration
{
    /**
     * Run the migrations.
     *
     *
     * 3.3.1.4.3.1.5 Project Address
     * 3.3.1.4.3.1.6 Project City
     * 3.3.1.4.3.1.7 Project State
     * 3.3.1.4.3.1.8 Project Zip
     * 3.3.1.4.3.1.9 Project Country
     * 3.3.1.4.3.1.10 Project County
     *
     * @return void
     */
    public function up()
    {
        Schema::table('projects', function (Blueprint $table) {
            $table->string('address', 64)->nullable();
            $table->string('city', 64)->nullable();
            $table->string('state', 64)->nullable();
            $table->string('zip', 64)->nullable();
            $table->string('county', 64)->nullable();
            $table->string('country', 64)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('projects', function (Blueprint $table) {
            $table->dropColumn('address');
            $table->dropColumn('city');
            $table->dropColumn('state');
            $table->dropColumn('zip');
            $table->dropColumn('county');
            $table->dropColumn('country');
        });
    }
}
