<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use App\User;

class ImpersonateUserController extends ApiController
{
    public function index(Request $request)
    {
        if (Auth::user()->role != 'superadmin') {
            return abort(405);
        }

        $user  = User::where('email', $request->input('email'))->first();

        if ($user == null) {
            abort(405);
        }

        $token = $user->createToken('Punchcard Impersonate')->accessToken;

        if ($token) {
            return $this->JsonSuccess('Success', ['info' => $token]);
        }

        abort(405);
    }
}
