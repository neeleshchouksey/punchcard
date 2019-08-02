<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Storage;
use App\Client;
use App\User;
use App\Project;
use File as File;

class CopyStockImagesSeeder extends Seeder
{
    /**
     * Provides some stock avatars & logos for testing
     *
     * @return void
     */
    public function run()
    {
        $this->copyStockImages();
    }

    public function copyStockImages()
    {
        $this->copyAvatars();
        $this->copyProjects();
        $this->copyLogos();
    }

    public function copyProjects()
    {
        $projects = Project::all();

        $stock   = Storage::disk('stock-images');
        $projectLogos  = Storage::disk('project-logos');

        $files = collect($stock->files('projects'));

        $i=0;
        foreach ($projects as $project) {
            if ($i%10) continue;
            $image = $files->random();
            $ext   = File::extension($image);
            $contents = $stock->get($image);

            $projectLogos->put($project->uniq_id . '.' . $ext, $contents);
        }
    }

    public function copyAvatars()
    {
        $users = User::all();

        $stock   = Storage::disk('stock-images');
        $avatars = Storage::disk('avatars');

        $files = collect($stock->files('avatars'));

        $i=0;
        foreach ($users as $user) {
            if ($i%15) continue;
            $image = $files->random();
            $ext   = File::extension($image);
            $contents = $stock->get($image);

            $avatars->put($user->uniq_id . '.' . $ext, $contents);
        }
    }

    public function copyLogos()
    {
        $clients = Client::all();

        $stock   = Storage::disk('stock-images');
        $logos = Storage::disk('logos');

        $files = collect($stock->files('logos'));

        $i=0;
        foreach ($clients as $client) {
            if ($i%5) continue;
            $image = $files->random();
            $ext   = File::extension($image);
            $contents = $stock->get($image);

            $logos->put($client->uniq_id . '.' . $ext, $contents);
        }
    }
}
