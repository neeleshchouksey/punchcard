<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
#use Carbon\Carbon;

class CreateTableChecks extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('checks', function (Blueprint $table) {
            $table->increments('id');
            $table->uuid('uniq_id')->unique();
            $table->integer('user_id')->unsigned();
            $table->integer('project_id')->unsigned();
            $table->dateTime('checkInDateTime')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->dateTime('checkOutDateTime')->nullable();
            $table->float('longitudeIn', 10, 6)->nullable();
            $table->float('latitudeIn', 10, 6)->nullable();
            $table->float('longitudeOut', 10, 6)->nullable();
            $table->float('latitudeOut', 10, 6)->nullable();
            $table->enum('checkMethod', ['geo', 'qr', 'manual'])->default('geo');
            $table->timestamps();

            $table->foreign('user_id')
                  ->references('id')->on('users');

            $table->foreign('project_id')
                  ->references('id')->on('projects');

            $table->index(['user_id', 'project_id', 'checkInDateTime', 'checkOutDateTime']);
            $table->index(['user_id', 'project_id', 'checkInDateTime']);
            $table->index(['user_id', 'project_id', 'checkOutDateTime']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('checks');
    }
}
