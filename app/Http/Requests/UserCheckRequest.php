<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Auth;
use App\UserRole;
use App\User;
use Validator;

class UserCheckRequest extends ApiRequest
{
    protected $userRole;
    protected $errorMsg = [];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return Auth::user()->id ? true : false;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'uniq_id' => 'sometimes|string|nullable|max:250',
            'latitude' => 'required|latitude',
            'longitude' => 'required|longitude',
            'exceptionReason' => 'sometimes|string|nullable|max:250',
            'checkMethod' => 'sometimes|string|nullable|max:250'
        ];
    }
}
