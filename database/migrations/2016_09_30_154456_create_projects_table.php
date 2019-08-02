<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProjectsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('projects', function (Blueprint $table) {
            $table->increments('id');
            $table->uuid('uniq_id')->unique();
            $table->string('name', 250);
            $table->string('description', 250);
            $table->integer('client_id')->unsigned();
            $table->integer('sector_id')->unsigned();
            $table->integer('industry_id')->unsigned();
            $table->date('startDate');
            $table->date('endDate');
            $table->float('longitude', 10, 6);
            $table->float('latitude', 10, 6);
            $table->float('radius', 10, 2)->default(0);
            $table->string('status', 12)->default('inactive');
            $table->jsonb('jdoc')->default('{}')->index();
            $table->timestamps();

            $table->foreign('client_id')
                  ->references('id')->on('clients');

            $table->foreign('sector_id')
                  ->references('id')->on('sectors')
                  ->onDelete('cascade');

            $table->foreign('industry_id')
                  ->references('id')->on('industries')
                  ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('projects');
    }
}
