<?php

namespace App\Http\Middleware;

use Closure;
use Request;
use Illuminate\Contracts\Auth\Factory as AuthFactory;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use App\Handlers\AuthFieldTypeHandler;
use Response;

class AuthenticateVeryBasicAuth
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
        $response = $next($request);

        if (Request::getUser() != 'tester' || Request::getPassword() != 'punchcard') {
            $headers = array('WWW-Authenticate' => 'Basic');
            return Response::make('Please login as a tester', 401, $headers);
        }

        return $response;
    }
}
