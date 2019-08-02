<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Auth;
use App\UserRole;
use App\User;
use Validator;
use Request;
use App;

class ProjectsUniqIdEmployeesRequest extends ApiRequest
{
    protected $userRole;
    protected $errorMsg = [];

    /**
     * Determine if the user is authorized to make this request.
     *
     * // Auth user must be on this project
     * // inverseapplications/punchcard-central/issues/88
     *
     * @return bool
     */

    public function authorize()
    {
        $userRole = resolve('App\UserRole', [Auth::User()]);

        //
        // Authoried for all projects
        //
        if ($userRole->isA('clientadmin')) {
            return true;
        }

        $uniq_id = $this->route('uniq_id');
        $project = App\Project::where('uniq_id', $uniq_id)->first();

        if ($userRole->isA('admin')) {
            //
            // If this project is one their company is added to
            //
            $clientProject = App\ClientProject::where('project_id', $project->id)
                    ->where('client_id', Auth::user()->client_id)->first();

            if ($clientProject === null) {
                return false;
            } else {
                return true;
            }
        }

        //
        // Checks if they are staffed on this project (superuser, user)
        //
        $projectUser = App\ProjectUser::where('project_id', $project->id)
            ->where('user_id', Auth::user()->id)->first();

        $this->errorMsg[] = "Not authorized to view endpoint, not on project";

        return isset($projectUser->id);
    }

    public function rules()
    {
        //
        // GET request,
        // the results need to be
        // in the controller
        //

        return [];
    }
}
