<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use App\Exceptions\BadInputException;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\UserRole;
use Validator;
use Auth;

class PostUserWebappRequest extends ApiRequest
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

    public function messages()
    {
        return [
            'name.name_title' => 'Please enter a name with letters, numbers and apostrophes.',
        ];
    }

    public function validate()
    {
        // can't do this until we can clean up input
        // but controller handles with only
        // parent::validate();

        $validator = Validator::make(Request::all(), [
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
                Rule::unique('users')->ignore(Auth::user()->id)
            ],
            'username' => [
                'required',
                'string',
                'max:64',
                Rule::unique('users')->ignore(Auth::user()->id)
            ],
            'mobileNumber' => [
                'digits_between:10,12',
                'required',
                'string',
                'max:64',
                Rule::unique('users')->ignore(Auth::user()->id)
            ],
            'jdoc' => ['array']
        ]);

        $passFail = $validator->passes();

        if (! $passFail) {
            throw new BadInputException(implode(', ', $validator->errors()->all()));
        }

        return $passFail;
    }
}
