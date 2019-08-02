<?php

use Illuminate\Database\Seeder;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\Helpers\Ecosystem\EcosystemClientAdminUsingWebApp;
use App\CheckStatsData;

class DataDumpForTestsSeeder extends Seeder
{
    use DatabaseTransactions;
    /**
     * Dumps data for tests so that when we re-seed, the data gets dumped in case
     * there are changes to the schemas it will be reflected in the dumps.
     *
     * @return void
     */
    public function run()
    {
        $this->dumpDataForClientAdminUsingWebAppZzzZzzCheckStats();
    }

    public function dumpDataForClientAdminUsingWebAppZzzZzzCheckStats()
    {
        $ecosystem = new EcosystemClientAdminUsingWebApp;
        list($viewingClientAdmin, $project, $checks) = $ecosystem->deliver();

        $checkStats = new CheckStatsData;
        $checkStats->setUser($viewingClientAdmin);
        $statsData  = $checkStats->getProjectStatsData($project->id);

        $fileName      = 'DataForClientAdminUsingWebAppZzzZzzCheckStats.json';
        $this->storage = Storage::disk('test-data');
        $this->storage->put($fileName, json_encode($statsData, true));
    }
}
