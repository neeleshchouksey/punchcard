<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\SearchProjectsUsers;
use App\ProjectUser;

class SaveSearchProjectUsers implements ShouldQueue
{
    use InteractsWithQueue, Queueable, SerializesModels;

    protected $project_id;
    protected $user_id;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($project_id, $user_id)
    {
        $this->project_id = $project_id;
        $this->user_id = $user_id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle(SearchProjectsUsers $searchProjectsUsers)
    {
        if ((new ProjectUser)->isOnProject($this->project_id, $this->user_id)) {
            return true; // already on project, so this job can be deleted
        }

        $searchProjectsUsers->create([
            'project_id' => $this->project_id,
            'user_id' => $this->user_id
        ]);
    }
}
