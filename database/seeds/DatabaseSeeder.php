<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        // These come first because projects depend on them
        //
        $this->call(IndustriesTableSeeder::class);
        $this->call(SectorsTableSeeder::class);
        $this->call(ClientsTableSeeder::class); // also does users and projects though could be extracted...

        //
        // More meta-ish, comes last
        //
        $this->call(ClientProjectTableSeeder::class);
        $this->call(ProjectUserTableSeeder::class);
        $this->call(ChecksTableSeeder::class);
        $this->call(UserLogTableSeeder::class);
        $this->call(DataDumpForTestsSeeder::class);
        $this->call(CopyStockImagesSeeder::class);
        //$this->call(PermissionUserTableSeeder::class);
    }
}
