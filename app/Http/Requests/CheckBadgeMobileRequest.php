<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use App\Exceptions;
use Auth;
use App\User;
use App\Project;
use App\ProjectUser;
use Validator;
use App\Traits\Requests\HasScannerAccess;
use App\Traits\Requests\CheckBadgeRequestPunchTrait;

class CheckBadgeMobileRequest extends ApiRequest
{
    use HasScannerAccess, CheckBadgeRequestPunchTrait;

    protected $errorMsg = [];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        $data = Request::all();

        list($project, $user, $data) = $this->punchSetup($data);

        $this->getInputSource()->replace($data);

        return $this->hasScannerAccess($project, $user, $data);
    }

    // rules definied in CheckBadgeRequestPunchTrait
}
