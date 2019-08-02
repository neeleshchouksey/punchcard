<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateClientProjectTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('client_project', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('client_id')->unsigned()->index();
            $table->integer('project_id')->unsigned()->index();
            $table->timestamps();

            $table->foreign('client_id')
                  ->references('id')->on('clients');

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
        Schema::dropIfExists('client_project');
    }
}
