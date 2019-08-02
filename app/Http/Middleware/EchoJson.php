<?php

namespace App\Http\Middleware;

use Closure;

class EchoJson
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if ($request->input('echo') == 'json') {
            die($request->getContent());
        }

        return $next($request);
    }
}
