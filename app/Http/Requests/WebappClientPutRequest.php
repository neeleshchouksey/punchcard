<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use Auth;
use App\Webapp\Clients\ClientWebapp;

#use App\User;

class WebappClientPutRequest extends ApiRequest
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

        $uniq_id = Request::input('uniq_id');

        if (!$uniq_id) {
            return false;
        }

        $client = ClientWebapp::where('uniq_id', $uniq_id)->first();

        if (! $this->canAuthUserAccess($client)) {
            return false;
        }

        return true;
    }

    protected function canAuthUserAccess($client)
    {
        $auth_client_id = Auth::user()->client_id;

        if ($auth_client_id == 1 && Auth::user()->role == 'superadmin') {
            return true;
        }

        if ($auth_client_id == $client->id ||
            $auth_client_id == $client->child_of_id) {
            return true;
        }

        return false;
    }

    public function messages()
    {
        return [
            'name.name_title' => 'Please enter a name with letters, numbers and apostrophes.',
        ];
    }

    public function rules()
    {
        $clientBeingUpdated = ClientWebapp::where('uniq_id', Request::input('uniq_id'))->first();

        return [
            'uniq_id' => 'required|uuid',
            'subdomain' => 'sometimes|string|max:64',
            'name' => 'required|string|name_title|max:250',
            'fein' => 'required|string|max:250|unique:clients,fein,' . $clientBeingUpdated->id,
            'dba' => 'sometimes|string|max:250',
            'address' => 'required|string|max:64',
            'city' => 'required|string|max:64',
            'state' => 'required|string|size:2',
            'zip' => 'required|string|max:12',
            'phone' => 'required|string|max:64|digits_between:10,12',
            'fax' => 'string|max:64|digits_between:10,12',
            'website' => 'string|max:128',
            'status' => 'sometimes|in:active,inactive',
            'jdoc' => 'sometimes|nullable|array' // converted to an array by this point
        ];
    }
}
