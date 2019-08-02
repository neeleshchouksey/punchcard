<?php namespace App\Http\Requests;

use App\Http\Requests\ApiRequest;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Validator;
use App\UserRole;
use Auth;

class ReportsToggleRequest extends ApiRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        $userRole = resolve('App\UserRole', [Auth::User()]);

        if (! $userRole->isAtLeast('superuser')) {
            return false;
        }

        return true;
    }

    public function rules()
    {
        return [
            'user_uniq_id' => 'required|uuid',
            'report_uniq_id' => 'required|uuid',
            'data' => 'array'
        ];
    }
}
