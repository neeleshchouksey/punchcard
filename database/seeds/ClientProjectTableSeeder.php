<?php

use Illuminate\Database\Seeder;

class ClientProjectTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $clients = App\Client::select(['clients.id'])->get();

        foreach ($clients as $client) {

            $projects = App\Project::select('id')
                ->where('client_id', '=', $client->id)
                ->get();

            //
            // Even though they are on the project.client_id, it's easier to pull
            // users just using the client_project system, so add them here, too
            //
            foreach ($projects as $project) {
                factory(App\ClientProject::class)
                    ->create([
                        'client_id' => $client->id,
                        'project_id' => $project->id
                    ]);
            }

            $children = App\Client::select(['clients.id'])
                ->where('clients.child_of_id', '=', $client->id)
                ->get();

            foreach ($children as $child) {

                $i = 0;
                foreach ($projects as $project) {
                    $i++;

                    //
                    // Skip every third one
                    //
                    // if (! ($i % 3)) {
                    //     continue;
                    // }

                    factory(App\ClientProject::class)
                        ->create([
                            'client_id' => $child->id,
                            'project_id' => $project->id
                        ]);
                }
            }
        }
    }
}
