<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use App\Exceptions\BadInputException;
use Illuminate\Validation\Rule;
use Validator;
use Auth;

class PutUserRequest extends ApiRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
    }

    public function validate()
    {
        // In the future DO this, but there is a lot out of sync right now and I've
        // acounted for it with only
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
