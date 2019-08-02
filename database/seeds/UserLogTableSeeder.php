<?php

use Illuminate\Database\Seeder;

class UserLogTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $users    = App\User::select(['id', 'client_id'])->get();

        foreach ($users as $user) {
            factory(App\UserLog::class, mt_rand(1, 15))
                ->create([
                    'user_id' => $user->id,
                ]);

            $projects = App\Project::select('id')->where('client_id', '=', $user->client_id)->get();
            foreach ($projects as $project) {
                factory(App\UserLog::class, mt_rand(2, 4))
                    ->create([
                        'user_id' => $user->id,
                        'project_id' => $project->id
                    ]);

                $checks = App\Check::where('user_id', '=', $user->id)
                    ->where('project_id', '=', $project->id)
                    ->get();

                $i=0;
                foreach ($checks as $check) {
                    if (++$i % 3 == 0) {
                        continue;
                    }

                    factory(App\UserLog::class)
                        ->create([
                            'user_id' => $check->user_id,
                            'project_id' => $check->project_id,
                            'check_id' => $check->id,
                        ]);
                }

            }
        }
    }
}
