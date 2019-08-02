<?php

use Illuminate\Database\Seeder;

class PermissionUserTableSeeder extends Seeder
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
            ->where('users.role', '<>', 'user')
            ->where('clients.status', '=', 'active')
            ->get();

        foreach ($users as $user) {
            factory(App\PermissionUser::class)
                ->create([
                    'user_id' => $user->id,
                ]
            );
        }
    }
}
