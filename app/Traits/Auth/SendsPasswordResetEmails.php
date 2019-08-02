<?php namespace App\Traits\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Request as RequestServer;
use App\User;
trait SendsPasswordResetEmails
{
    /**
     * Display the form to request a password reset link.
     *
     * @return \Illuminate\Http\Response
     */
    public function showLinkRequestForm()
    {
        return view('auth.passwords.email');
    }
    /**
     * Send a reset link to the given user.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function sendResetLinkEmail(Request $request)
    {
    
        $this->validate($request, ['email' => 'required|email']);
        // We will send the password reset link to this user. Once we have attempted
        // to send the link, we will examine the response then see the message we
        // need to show to the user. Finally, we'll send out a proper response.
        $email = $request->only('email');
        $userCount = User::where('email', $email['email'])->where('remember_token', '!=', NULL)->count();

        if($userCount == 0){
        
            return array("result" => 'error',
            "message" => 'please complete Registration first',
            "http_code" => 422,
            "data" => []);
        }
    
        $credentials = ['field' => 'email', 'value' => $email['email']];
        list($credentials['subdomain'],) = explode('.', RequestServer::server('HTTP_HOST'));
        $response = $this->broker()->sendResetLink($credentials);
    
        
        if ($response === Password::RESET_LINK_SENT) {
            return back()->with('status', trans($response));
        }
        // If an error was returned by the password broker, we will get this message
        // translated so we can notify a user of the problem. We'll redirect back
        // to where the users came from so they can attempt this process again.
        return back()->withErrors(
            ['email' => trans($response)]
        );
    }
    /**
     * Get the broker to be used during password reset.
     *
     * @return \Illuminate\Contracts\Auth\PasswordBroker
     */
    public function broker()
    {
        return Password::broker('pwdreset'); // config/auth.php; special to inverse
    }
}