<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUserLogsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_logs', function (Blueprint $table) {
            $table->increments('id');
            $table->uuid('uniq_id')->unique();
            $table->integer('user_id')->unsigned();
            $table->integer('project_id')->unsigned()->nullable()->index();
            $table->text('note');
            $table->string('type', 24);
            $table->dateTime('dateTime')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamps();

            $table->foreign('user_id')
                  ->references('id')->on('users');

            $table->foreign('project_id')
                  ->references('id')->on('projects');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_logs');
    }
}
