<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

class Plans
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
        if($user = Auth::user()){
            return redirect('api/v1.0/webapp/plans');
              // return $next($request);
        }
      
         
    }
}
