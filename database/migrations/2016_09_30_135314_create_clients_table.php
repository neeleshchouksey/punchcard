<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Ramsey\Uuid\Uuid;

class CreateClientsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('clients', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('child_of_id')->unsigned()->default(0)->index();
            $table->uuid('uniq_id')->unique();
            $table->string('subdomain', 64)->unique();
            $table->string('name', 255);
            $table->string('fein', 250)->unique();
            $table->string('dba', 250)->nullable();
            $table->string('address', 64)->nullable();
            $table->string('city', 64)->nullable();
            $table->string('state', 2)->nullable();
            $table->string('zip', 12)->nullable();
            $table->string('phone', 64)->nullable();
            $table->string('fax', 64)->nullable();
            $table->string('website', 64)->nullable();
            $table->string('status', 12)->default('inactive');
            $table->jsonb('jdoc')->default('{}')->index();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('clients');
    }
}
