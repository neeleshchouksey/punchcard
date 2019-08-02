<?php namespace App\Http\Requests;

use Auth;
use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use App\Webapp\Clients\ClientWebapp;

class WebappClientContactRequest extends ApiRequest
{
    protected $errorMsg = [];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        //
        // isAtLeast is covered in middlware
        //

        return true;
    }

    public function all()
    {
        $attributes = parent::all();
        $attributes['data']['phone'] = preg_replace('#[^0-9]#', '', $attributes['data']['phone']);

        $this->replace($attributes);
        return $attributes;
    }

    public function rules()
    {
        return [
            'uniq_id' => 'required|uuid',
            'data' => 'required|array',
            'data.name' => 'required|string|name_title|max:64',
            'data.email' => 'required|email|max:64',
            'data.phone' => 'required|digits_between:10,12',
        ];
    }

    public function messages()
    {
        return [
            'data.name.name_title' => 'Please enter a first_name with letters, numbers and apostrophes.',
        ];
    }
}
