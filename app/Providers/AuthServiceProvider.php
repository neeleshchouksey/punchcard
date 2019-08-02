<?php

namespace App\Providers;

use DB;
use Carbon\Carbon;
use Laravel\Passport\Passport;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use App\UserAdmin;
use App\Policies\UserAdminPolicy;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        'App\Model' => 'App\Policies\ModelPolicy',
        UserAdmin::class => UserAdminPolicy::class,
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        Passport::routes();
        Passport::tokensExpireIn(Carbon::now()->addDays(15));
        Passport::refreshTokensExpireIn(Carbon::now()->addDays(30));
        Passport::pruneRevokedTokens(); 
       // Passport::enableImplicitGrant();
        // Passport::enableImplicitGrant();

        //
        // For password reset
        //
  
        Auth::provider('inverse', function ($app, array $config) {
            return new InverseUserProvider(DB::connection('pgsql'), $app['hash'], 'users');
        });

        Gate::define('view-employee', function ($user) {
            $at_least = config('roles.at_least', []);
            $accessLevels = $at_least['superuser'] ?: [];
            return in_array($user()->role, $accessLevels);
        });
    }
}
