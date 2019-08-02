<?php namespace App\Http\Requests;

use Auth;
use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use App\Webapp\Clients\ClientWebapp;

class WebappClientParentPostRequest extends ApiRequest
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
        // isAtLeast is covered in middleware
        //

        return true;
    }

    public function messages()
    {
        return [
            'name.name_title' => 'Please enter a name with letters, numbers and apostrophes.',
        ];
    }

    public function rules()
    {
        return [
            'subdomain' => 'required|string|max:64',
            'name' => 'required|string|name_title|max:250',
            'fein' => 'required|string|max:250|unique:clients,fein',
            'dba' => 'sometimes|string|max:250',
            'address' => 'required|string|max:64',
            'city' => 'required|string|max:64',
            'state' => 'required|string|size:2',
            'zip' => 'required|string|max:12',
            'phone' => 'required|string|max:64|digits_between:10,12',
            'fax' => 'string|max:64|digits_between:10,12',
            'website' => 'string|max:128',
            'status' => 'required|in:active,inactive',
            'image' => 'sometimes',
            'jdoc' => 'sometimes|nullable|array' // converted to an array by this point
        ];
    }
}
