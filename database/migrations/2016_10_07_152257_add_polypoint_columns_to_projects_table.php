<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddPolypointColumnsToProjectsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $sql = 'ALTER TABLE "projects" ADD "polyfence" polygon NULL';
        DB::connection()->getPdo()->exec($sql);

        $sql = 'ALTER TABLE "projects" ADD "pointfence" point NULL';
        DB::connection()->getPdo()->exec($sql);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('projects', function ($t) {
            $t->dropColumn('polyfence');
            $t->dropColumn('pointfence');
        });
    }
}
