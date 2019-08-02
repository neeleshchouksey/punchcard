<?php namespace App\Http\Middleware;

use Closure;

class RemoveWwwAuthHeader {
    /**
     * Strip X-Requested-With from the request because we're handling
     * all json output and don't want interference from Laravel.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $response = $next($request);

        $response->headers->remove('WWW-Authenticate');

        return $response;
    }
}
