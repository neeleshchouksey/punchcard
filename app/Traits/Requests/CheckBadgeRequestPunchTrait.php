<?php namespace App\Traits\Requests;

use App\Project;
use App\ProjectUser;
use App\User;
use Auth;
use App\Exceptions;

trait CheckBadgeRequestPunchTrait
{
    protected function punchSetup($data)
    {
        $data           = $this->splitBadgeId($data);
        $projectViewing = Project::where('uniq_id', $data['uniq_id'])->first();
        $project        = Project::find($data['project_id']);
        $user           = User::find($data['user_id']);

        $data['checkMethod'] = 'manual';

        $this->abortIfDataInvalid($data, $project, $user, $projectViewing);
        $this->abortIfCheckingInSelf($user);

        $data['user'] = $user;
        $data['project'] = $project;

        return [$project, $user, $data];
    }

    protected function abortIfCheckingInSelf($user)
    {
        //
        // Specfic to badges, can't check themselves in with a badge_id
        //

        if ($user->id == Auth::user()->id) {
            throw new Exceptions\BadInputException("User cannot check self in using badge_id");
        }
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
            'badge_id' => 'required|integer',
            'latitude' => 'required|latitude',
            'longitude' => 'required|longitude',
            'exceptionReason' => 'sometimes|string|nullable|max:250'
        ];
    }

    /**
     * spliteBadgeId
     *
     * split badge_id into
     *  - a user_id (who is being checked in) and
     *  - project_id (which project is being checked in to)
     *
     * @param mixed $data
     */
    protected function splitBadgeId($data)
    {
        $badge_data = ProjectUser::find($data['badge_id']);

        $data['user_id']    = $badge_data['user_id'];
        $data['project_id'] = $badge_data['project_id'];

        return $data;
    }

    protected function abortIfDataInvalid($data, $project, $user, $projectViewing)
    {

        if (is_null($project) or is_null($user)) {
            throw new Exceptions\BadInputException("Invalid badge ID. Since this badge was created, the project has been deactived or removed or the user is not active or has been removed from the project.");
        }

        if (! $projectViewing or ($projectViewing->id <> $project->id)) {
            throw new Exceptions\BadInputException("The project for this badge is not active, or does not match the project being checked into. Check that the correct badge is being used.");
        }

        if (!$user->id) {
            throw new Exceptions\BadInputException("User being checked in was not found");
        }

        if (!$project->id) {
            throw new Exceptions\BadInputException("Project being checked in was not found");
        }

        if ($user->status <> 'active') {
            throw new Exceptions\BadInputException("User being checked in is not active");
        }

        if ($project->status <> 'active') {
            throw new Exceptions\BadInputException("Project being checked in is not active");
        }

        //
        // Per Matt, this is not a requirement; maybe in v2, though.
        // Reason: a parent company may hire/outsource a management company
        // that would scan parents and other children of the parent.
        //
        // if ($user->client_id <> Auth::user()->client_id) {
        //     throw new Exceptions\BadInputException("User scanning and user being checked in are not in the same company");
        // }

        return $data;
    }
}
