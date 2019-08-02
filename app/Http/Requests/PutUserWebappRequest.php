<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use App\Exceptions\BadInputException;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\UserRole;
use App\User;
use Validator;
use Auth;

//
// Specific to webapp updating a different user than the logged in user.
// Can't be used with a user updating their own profile!
//
class PutUserWebappRequest extends ApiRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        $userRole = resolve('App\UserRole', [Auth::User()]);

        if (! $userRole->isAtLeast('admin')) {
            return false;
        }

        return true;
    }

    public function rules()
    {
        return [];
    }

    public function validate()
    {

        // can't do this until we can clean up input
        // but controller handles with only parent::validate();
        // parent::validate();

        $userBeingViewed = User::where('uniq_id', Request::input('uniq_id'))->first();

        if (!$userBeingViewed) {
            return false;
        }

        $validator = Validator::make(Request::all(), [
            'uniq_id' => [
                'required',
                'uuid'
            ],
            'first_name' => [
                'required',
                'string',
                'name_title',
                'max:64'
            ],
            'last_name' => [
                'required',
                'string',
                'name_title',
                'max:64'
            ],
            'email' => [
                'required',
                'string',
                'email',
                Rule::unique('users')->ignore($userBeingViewed->id)
            ],
            'username' => [
                'required',
                'string',
                'max:64',
                Rule::unique('users')->ignore($userBeingViewed->id)
            ],
            'mobileNumber' => [
                'digits_between:10,12',
                'required',
                'string',
                'max:64',
                Rule::unique('users')->ignore($userBeingViewed->id)
            ],
            'jdoc' => ['array']
        ]);

        $passFail = $validator->passes();

        if (! $passFail) {
            throw new BadInputException(implode(', ', $validator->errors()->all()));
        }

        return $passFail;
    }

    public function messages()
    {
        return [
            'name.name_title' => 'Please enter a name with letters, numbers and apostrophes.',
        ];
    }
}
