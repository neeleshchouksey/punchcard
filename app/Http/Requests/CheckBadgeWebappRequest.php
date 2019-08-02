<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use App\Exceptions;
use Auth;
use App\User;
use App\Project;
use App\UserRole;
use App\ProjectUser;
use Validator;
use App\Traits\Requests\CheckBadgeRequestPunchTrait;

class CheckBadgeWebappRequest extends ApiRequest
{
    use CheckBadgeRequestPunchTrait;

    protected $errorMsg = [];

    /**
     * Determine if the user is authorized to make this request.
     * Note: because of the way CheckBadgeMobileRequest was written and required
     * data for the authorization, and to keep things as DRY as possible, this uses
     * the same system so we do some data arranging here, where we might not need
     * to do this here otherwise.
     *
     * @return bool
     */
    public function authorize()
    {
        list($project, $user, $data) = $this->punchSetup(Request::all()); // these will be availabe in the controller
        $this->getInputSource()->replace($data);

        $userRole = resolve('App\UserRole', [Auth::User()]);

        if ($userRole->isAtLeast('superuser')) {
            return true;
        }

        return false;
    }

    // rules definied in CheckBadgeRequestPunchTrait
}
