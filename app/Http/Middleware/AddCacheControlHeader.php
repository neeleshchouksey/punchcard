<?php namespace App\Http\Middleware;

use Closure;

class AddCacheControlHeader {
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

        $response->header('Cache-Control', 'public, max-age=3600, must-revalidate');

        return $response;
    }
}
