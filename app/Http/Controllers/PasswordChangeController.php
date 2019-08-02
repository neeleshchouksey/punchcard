<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use Hash;
use App\User;
use Auth;

class PasswordChangeController extends ApiController
{
    public function put(Request $request)
    {
        $this->validate($request, [
            'current_password' => 'required',
            'new_password' => 'required|confirmed',
        ]);

        $user = User::find(Auth::user()->id);

        if (! Hash::check($request->input('current_password'), $user->password)) {
            return $this->jsonFailure('current password not matched');
        }

        try {
            $user->password = bcrypt($request->input('new_password'));
            $user->save();
        } catch (\Exception $e) {
            return $this->jsonFailure('password not changed: ' . $e->getMessage(), []);
        }

        $CaEmail = $user->email;

        \Mail::send('email_tem.resetPasswordSuccessmsg', ['username'=>$user->first_name], function($message)use ($CaEmail) {

                    $message->to($CaEmail);
                    $message->bcc('admin@punchcardllc.com');
                    $message->subject('Punchcard Account Information Change');
                 });
        return $this->jsonSuccess('password changed', $user);
    }
}
