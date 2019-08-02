<?php namespace App;

use App\Contracts\ProjectsAccessUserInterface;
//use App\Project;

class ProjectsAccessAsAdmin implements ProjectsAccessUserInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function remove($uniq_id)
    {
        $project = ProjectFull::where('client_id', $this->authUser->client->child_of_id)
            ->where('uniq_id', $uniq_id)
            ->first();

        return $project->delete();
    }

    public function getOne($uniq_id)
    {
        //
        // Admin's child companies do not have their own projects, thus we use the 'child_of_id'
        // here to get the list of the ALL (not just active) projects for the parent company
        //
        return ProjectFull::where('client_id', $this->authUser->client->child_of_id)->where('uniq_id', $uniq_id);
    }

    public function getManyForExport()
    {
        return Project::join('client_project', 'projects.id', '=', 'client_project.project_id')
            ->where('client_project.client_id', $this->authUser->client_id);
    }

    public function getMany()
    {
        //
        // 7.3.2.1 The Admin should be able to view a list of all projects for their
        //  own [Child] Company that were created by the Parent Company of
        //  the web app the Admin is logged into
        //
        // Clarification: from slack on 12/5/2016. An 'admin' should see projects
        // from the parent, regardless of whether they are staffed on them, since
        // they will be adding people to the projects. There are no child company
        // projects.
        //
        // Thus: select from client_project where the child company id is the admin's
        // Auth::user()->client_id
        //

        return ProjectFull::join('client_project', 'projects.id', '=', 'client_project.project_id')
            ->where('client_project.client_id', $this->authUser->client_id);
    }
}
