<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddClientIdToUsers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users', function ($table) {
            $defaultJdoc = '{"address": {"address1": ""}, "vehicle": {"carMake": ""}, "emerContact": {"name": ""}, "payroll_data": {"pay_rate": ""}}';

            $table->uuid('uniq_id')->unique();
            $table->integer('client_id')->unsigned();
            $table->string('mobileNumber', 24)->nullable();
            $table->string('role', 12)->default('user');
            $table->enum('status', ['active', 'inactive'])->default('inactive')->index();
            $table->jsonb('jdoc')->default($defaultJdoc)->index();

            $table->foreign('client_id')
                  ->references('id')->on('clients')
                  ->onDelete('cascade');

            $table->unique(['client_id', 'email']);
            $table->unique(['client_id', 'mobileNumber']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function ($t) {
            $t->dropColumn('client_id');
        });
    }
}
