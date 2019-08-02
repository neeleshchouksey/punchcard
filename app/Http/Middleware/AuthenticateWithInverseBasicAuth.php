<?php

namespace App\Http\Middleware;

use Closure;
use Request;
use Illuminate\Contracts\Auth\Factory as AuthFactory;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use App\Handlers\AuthFieldTypeHandler;

class AuthenticateWithInverseBasicAuth
{
    /**
     * The guard factory instance.
     *
     * @var \Illuminate\Contracts\Auth\Factory
     */
    protected $auth;

    /**
     * Create a new middleware instance.
     *
     * @param  \Illuminate\Contracts\Auth\Factory  $auth
     * @return void
     */
    public function __construct(AuthFactory $auth, AuthFieldTypeHandler $authFieldType)
    {
        $this->auth = $auth;
        $this->authFieldType = $authFieldType;
    }

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string|null  $guard
     * @return mixed
     */
    public function handle($request, Closure $next, $guard = null)
    {
        //dd($request);
        $user = $request->getUser();
        list($subdomain,) = explode('.', $request->server('HTTP_HOST'));
        $subdomain = strtolower($subdomain);
        /*var_dump($user);
        var_dump($subdomain);
        exit;*/
        $userField = $this->authFieldType->determineType($user);
        $credentials = ['field' => $userField,
                        'value' => $user,
                        'subdomain' => $subdomain];
        return Auth::onceBasic($userField, $credentials) ?: $next($request);
    }
}
