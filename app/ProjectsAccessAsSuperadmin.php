<?php namespace App;

use App\Contracts\ProjectsAccessUserInterface;
use DB;

class ProjectsAccessAsSuperadmin implements ProjectsAccessUserInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function remove($uniq_id)
    {
        return null;
    }

    public function getOne($uniq_id)
    {
        return ProjectFull::where('client_id', $this->authUser->client_id)->where('uniq_id', $uniq_id);
    }

    public function getManyForExport()
    {
        return Project::where('id', '<>', '0'); // all but with query builder
    }

    public function getMany()
    {
        return ProjectFull::join('clients', 'clients.id', '=', 'projects.client_id')
            ->where('child_of_id', 0);
    }
}
