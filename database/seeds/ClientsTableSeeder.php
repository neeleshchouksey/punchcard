<?php

use Illuminate\Database\Seeder;
use DB as DB;

class ClientsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->createClientActive();
        $this->createClientRandom();
        $this->updateToRealistic();
    }

    public function getParentRoles()
    {
        return [
            'clientadmin',
            'superuser',
            'user'
        ];
    }

    public function getChildRoles()
    {
        return [
            'admin',
            'user'
        ];
    }

    public function createClientActive($parent_client = null)
    {
        if ($parent_client) {
            // these are the CHILDREN
            $clients = factory(App\Client::class, 5)->create(['child_of_id' => $parent_client->id, 'status' => 'active']);
            $roles   = $this->getChildRoles();
        } else {
            // THESE are the parents
            $clients = factory(App\Client::class, 10)->create(['status' => 'active']);
            $roles   = $this->getParentRoles();
        }

        foreach ($clients as $client) {

            foreach ($roles as $role) {
                //
                // Active users
                //
                factory(App\User::class, 3)
                    ->create(['client_id' => $client->id, 'status' => 'active', 'role' => $role]);

                //
                // Random active/inactive users
                //
                factory(App\User::class, 3)
                    ->create(['client_id' => $client->id, 'role' => $role]);
            }

            // meaning these ARE parent clients; it is set when we are adding
            // a child, and the children don't have projects or children
            if (! $parent_client) {
                //
                // Active projects
                //
                factory(App\Project::class, 2)
                    ->create(['client_id' => $client->id, 'status' => 'active']);

                //
                // Random active/inactive projects
                //
                factory(App\Project::class, 2)
                    ->create(['client_id' => $client->id]);

                //
                // CHILD companies
                //
                    $this->createClientActive($client);
            }
        }
    }

    public function createClientRandom()
    {
        factory(App\Client::class, 2)
            ->create()
            ->each(function ($client) {
                factory(App\User::class, 4)
                    ->create(['client_id' => $client->id]);

                factory(App\Project::class, 3)
                    ->create(['client_id' => $client->id]);
            });
    }

    public function updateToRealistic()
    {
        DB::table('clients')->where('id', 2)->update([
            'subdomain' => 'gilbane',
            'name' => 'Gilbane'
        ]);

        DB::table('clients')->where('id', 3)->update([
            'subdomain' => 'skanska',
            'name' => 'Skanska'
        ]);

        DB::table('clients')->where('id', 4)->update([
            'subdomain' => 'bechtel',
            'name' => 'Bechtel'
        ]);

        DB::table('clients')->where('id', 5)->update([
            'subdomain' => 'clark',
            'name' => 'Clark'
        ]);

        DB::table('clients')->where('id', 6)->update([
            'subdomain' => 'turner',
            'name' => 'Turner'
        ]);

        DB::table('clients')->where('id', 7)->update([
            'subdomain' => 'fluor',
            'name' => 'Fluor'
        ]);

        DB::table('clients')->where('id', 8)->update([
            'subdomain' => 'aecom',
            'name' => 'Aecom'
        ]);

        DB::table('clients')->where('id', 9)->update([
            'subdomain' => 'jacobs',
            'name' => 'Jacobs'
        ]);

        DB::table('clients')->where('id', 10)->update([
            'subdomain' => 'dpr',
            'name' => 'DPR'
        ]);

        DB::table('clients')->where('id', 11)->update([
            'subdomain' => 'kiewit',
            'name' => 'Kiewit'
        ]);

    }
}
