<?php namespace App\Http\Middleware;

use Auth;
use Closure;

class AuthorizeAtLeast
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next, $level)
    {
        $at_least = config('roles.at_least', []);
        $accessLevels = $at_least[$level] ?: [];
        
        //$accessLevels="superuser";

        if (! in_array(Auth::user()->role, $accessLevels)) {
            return response()->json([
                'result' => 'error',
                'data' => null,
                'http_code' => 403,
                'message' => 'Not authorized',
            ], 403, [], JSON_PRETTY_PRINT);
        }

        return $next($request);
    }
}
