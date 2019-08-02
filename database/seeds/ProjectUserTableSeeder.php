<?php

use Illuminate\Database\Seeder;

class ProjectUserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $users      = App\User::select(['users.id', 'users.client_id'])
            ->join('clients', 'clients.id', '=', 'users.client_id')
            ->where('users.status', '=', 'active')
            ->where('clients.status', '=', 'active')
            ->get();

        foreach ($users as $user) {
            $projects = App\ClientProject::select('project_id')
                ->where('client_id', '=', $user->client_id)
                ->get();

            foreach ($projects as $project) {
                factory(App\ProjectUser::class)
                    ->create([
                        'user_id' => $user->id,
                        'project_id' => $project->project_id
                    ]);
            }
        }
    }
}
