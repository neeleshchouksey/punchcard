<?php namespace App\Http\Requests;

use Illuminate\Http\Request;
use Auth;
use App\Check;
use App\Project;
use App\ProjectUser;

class UserLogsPostRequest extends ApiRequest
{

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        // 2.2.3.3.1.1 A user should only have the ability to enter log notes if they are Punched In to a project
        // - They are on the project
        // - They are checked into project

        $project = Project::where('uniq_id', Request::input('uniq_id'))->first();

        if (! $project) {
            $this->errorMsg[] = "Project not found";
            return false;
        }

        $projectUser = new ProjectUser;

        if (! $projectUser->isOnProject($project->id, Auth::user()->id)) {
            $this->errorMsg[] = "Currently logged in user is not staffed on this project.";
            return false;
        }

        if (! Check::isCheckedInTo(Auth::user(), $project)) {
            $this->errorMsg[] = "Currently logged in user is not already checked in to project.";
            return false;
        }

        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'uniq_id' => 'required|uuid',
            'note' => 'required|string'
        ];
    }
}
