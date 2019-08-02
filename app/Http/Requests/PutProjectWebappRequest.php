<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\UserRole;
use Validator;
use Auth;

class PutProjectWebappRequest extends ApiRequest
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
            'uniq_id' => 'required|uuid',
            'name' => 'required|string|max:250',
            'description' => 'required|string|max:250',
            'startDate' => 'required|date',
            'endDate' => 'required|date',
            'address' => 'required|string|max:64',
            'city' => 'required|string|max:64',
            'state' => 'required|string|size:2',
            'zip' => 'required|string|max:12',
            'county' => 'sometimes|string|max:64',
            'country' => 'sometimes|string|max:64',
            'radius' => 'required|numeric',
            'polyfence' => 'required|string|nullable',
            'pointfence' => 'required|string|nullable',
            'status' => 'required|in:active,inactive',
            'jdoc' => 'sometimes|nullable|array', // converted to an array by this point
            'latitude' => 'required|latitude',
            'longitude' => 'required|longitude',
        ];
    }
}
