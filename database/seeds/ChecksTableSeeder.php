<?php

use Illuminate\Database\Seeder;
use App\Helpers\Dates;
use App\Project;

class ChecksTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = \Faker\Factory::create();
        $users = App\User::select(['id', 'client_id'])->get();

        foreach ($users as $user) {
            $projects = App\ProjectUser::select('project_id')->where('user_id', '=', $user->id)->get();

            foreach ($projects as $project) {
                //
                // Trying to be more realistic and seed over a daily schedule not all in one or two days
                //
                $num = mt_rand(5, 20);
                $now = Dates::makeDate(date('Y-m-d H:i:s'));
                $thisDate = $now->subDays(($num+1)); // to make it more realistic, we'll go back in time to these days

                for ($i=0; $i<$num; $i++) {
                    $thisDate = $thisDate->addDay();
                    $endHour = mt_rand(15, 23);

                    $longitudeIn  = $faker->longitude;
                    $latitudeIn   = $faker->latitude;
                    $longitudeOut = $faker->longitude;
                    $latitudeOut  = $faker->latitude;

                    $completeProject = Project::find($project->project_id);
                    $isExceptionIn   = !$completeProject->isWithinCheckinDistance($latitudeIn, $longitudeIn);
                    $isExceptionOut  = !$completeProject->isWithinCheckinDistance($latitudeOut, $longitudeOut);

                    factory(App\Check::class)
                        ->create([
                            'checkInDateTime' => $thisDate->format('Y-m-d') . ' 14:00:00', // account for UTC
                            'checkOutDateTime' => $thisDate->format('Y-m-d') . ' ' . $endHour . ':00:00',
                            'longitudeIn' => $longitudeIn,
                            'latitudeIn' => $latitudeIn,
                            'longitudeOut' => $longitudeOut,
                            'latitudeOut' => $latitudeOut,
                            'isExceptionIn' => $isExceptionIn,
                            'isExceptionOut' => $isExceptionOut,
                            'user_id' => $user->id,
                            'project_id' => $project->project_id,
                        ]);
                }
            }
        }
    }
}
