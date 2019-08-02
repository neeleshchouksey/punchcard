<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\UserRole;
use Validator;
use Auth;

class PostProjectWebappRequest extends ApiRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        $userRole = resolve('App\UserRole', [Auth::User()]);

        if (! $userRole->isAtLeast('clientadmin')) {
            return false;
        }

        return true;
    }

    public function rules()
    {
        return [
            'client_uniq_id' => 'required|uuid',
            'name' => 'required|string|max:250',
            'description' => 'required|string|max:250',
            'image' => 'sometimes',
            'address' => 'required|string|max:64',
            'city' => 'required|string|max:64',
            'state' => 'required|string|size:2',
            'county' => 'sometimes|string|max:64',
            'country' => 'sometimes|string|max:64',
            'zip' => 'required|string|max:12',
            'startDate' => 'required|date',
            'endDate' => 'required|date',
            'polyfence' => 'required|string|nullable',
            'pointfence' => 'required|string|nullable',
            'radius' => 'required|numeric',
            'status' => 'required|in:active,inactive',
            'jdoc' => 'sometimes|nullable|array', // converted to an array by this point
            'latitude' => 'required|latitude',
            'longitude' => 'required|longitude',
        ];
    }
}
