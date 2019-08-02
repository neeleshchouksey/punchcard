<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ChecksAddDatetimeIndexes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('checks', function ($table) {
            $table->index('checkInDateTime');
            $table->index('checkOutDateTime');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('checks', function ($table) {
            $table->dropIndex(['checkInDateTime']);
            $table->dropIndex(['checkOutDateTime']);
        });
    }
}
