<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use Auth;
use App\User;
use App\Project;
use Validator;
use App\Traits\Requests\HasScannerAccess;
use App\Traits\Requests\CheckBadgeRequestPunchTrait;

class CheckQrRequest extends ApiRequest
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

        $data['user'] = $user;
        $data['project'] = $project;
        $this->getInputSource()->replace($data);

        return $this->hasScannerAccess($project, $user, $data);
    }

    protected function punchSetup($data)
    {
        $projectViewing = Project::where('uniq_id', $data['viewing_project_uniq_id'])->first();
        $project        = Project::where('uniq_id', $data['qr_provided_project_uniq_id'])->first();
        $user           = User::where('uniq_id', $data['qr_provided_user_uniq_id'])->first();

        $data['project_id'] = $project->id;
        
        $data['user_id']    = $user->id;
        if($data['exceptionReason'] == 'QR input'){
            $data['checkMethod'] = 'qr';
        }else{
            $data['checkMethod'] = 'face';
        }
        

        $this->abortIfDataInvalid($data, $project, $user, $projectViewing);

        return [$project, $user, $data];
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'viewing_project_uniq_id' => 'required|uuid',
            'qr_provided_user_uniq_id' => 'required|uuid',
            'qr_provided_project_uniq_id' => 'required|uuid',
            'latitude' => 'required|latitude',
            'longitude' => 'required|longitude',
            'exceptionReason' => 'sometimes|string|nullable|max:250'
        ];
    }
}
