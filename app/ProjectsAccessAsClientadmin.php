<?php namespace App;

use App\Contracts\ProjectsAccessUserInterface;
//use App\ProjectsFull;

class ProjectsAccessAsClientadmin implements ProjectsAccessUserInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function remove($uniq_id)
    {
        $project = ProjectFull::where('client_id', $this->authUser->client_id)
            ->where('uniq_id', $uniq_id)
            ->first();

        return $project->delete();
    }

    public function getOne($uniq_id)
    {
        return ProjectFull::where('client_id', $this->authUser->client_id)->where('uniq_id', $uniq_id);
    }

    public function getManyForExport()
    {
        return Project::where('client_id', $this->authUser->client_id);
    }

    public function getMany()
    {
        //
        // 6.3.2.1
        // The Client Admin should be able to view a list of all projects for their own [Parent] Company
        //
        return ProjectFull::where('client_id', $this->authUser->client_id);
    }
}
