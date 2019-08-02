<?php namespace App;

use Auth;
use App\User;
use App\Project;
use App\Contracts\ProjectsAccessUserInterface;
use Illuminate\Http\Request;

/**
 * Class: ProjectsUserPermittedToAccess
 * Based on the User $authUser role/user type, this will pull down projects.
 * And admin or above will see all projects in the company.
 *
 */
class ProjectsUserPermittedToAccess
{
    protected $inRequest;
    protected $inUser;
    protected $columns = [
                'projects.id',
                'projects.client_id', // needed for logo!
                'projects.name',
                'projects.uniq_id',
                'projects.description',
                'startDate',
                'endDate',
                'latitude',
                'projects.status',
                'longitude',
                'radius',
                'projects.address',
                'projects.city',
                'projects.state',
                'projects.zip',
                'projects.country',
                'polyfence',
            ];

    public function __construct(Request $request, ProjectsAccessUserInterface $authUser)
    {
        $this->inRequest = $request;
        $this->inUser = $authUser;
    } 

    public function setColumns($columns = ['*'])
    {
        $this->columns= $columns;
        return $this;
    }

    public function remove($uniq_id)
    {
        return $this->inUser->remove($uniq_id);
    }

    public function getProject($uniq_id)
    {
        $projectAsUser = $this->inUser->getOne($uniq_id);
        return $projectAsUser->select(
            [
                'projects.id',
                'projects.client_id', // needed for logo!
                'projects.name',
                'projects.address',
                'projects.city',
                'projects.state',
                'projects.zip',
                'projects.county',
                'projects.country',
                'projects.uniq_id',
                'projects.description',
                'status',
                'startDate',
                'endDate',
                'latitude',
                'longitude',
                'polyfence',
                'pointfence',
                'radius',
            ]
        )->first();
    }

    public function getManyProjects($paginated = true)
    {
        $projectsAsUser = $this->inUser->getMany();
        $projectsAsUser->orderBy('startDate', 'DESC');
        $projectsAsUser->select($this->columns);

        if ($paginated) {
            return $projectsAsUser->paginate($this->inRequest->query('per_page', 9999));
        } else {
            return $projectsAsUser->get();
        }
    }

    public function getManyProjectsForReports()
    {
        $columns = $this->columns;

        if (Auth::user()->role == 'superadmin') {
            $columns[] = 'clients.uniq_id as client_uniq_id';
        } else {
            $columns[] = \DB::raw('null as client_uniq_id');
        }

        $projectsAsUser = $this->inUser->getMany();
        $projectsAsUser->orderBy('startDate', 'DESC');
        $projectsAsUser->select($columns);

        return $projectsAsUser->get();
    }

    public function getManyProjectsForExport()
    {
        $projectsAsUser = $this->inUser->getManyForExport();
        return $projectsAsUser->select(['*'])->orderBy('startDate', 'DESC')->get();
    }
}
