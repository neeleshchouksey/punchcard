<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Validator;
use Log;
use DB;
use App\Webapp\Users\Add as UserAdd;
use App\Observers\UserObserver;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        $this->bootObservers();
        $this->bootValidators();

        DB::listen(function ($query) {
            Log::info($query->sql);
            Log::info($query->bindings);
        });
    }

    protected function bootObservers()
    {
        UserAdd::observe(UserObserver::class);
    }

    protected function bootValidators()
    {
        Validator::extend('uuid', function ($attribute, $value, $parameters, $validator) {
            if ($value === null) {
                return true;
            }

            return preg_match('/^\{?[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}\}?$/', $value);
        });


        // http://www.altafweb.com/2013/11/validate-latitude-and-longitude-with.html
        //
        //The latitude must be a number between -90 and 90 and the longitude between -180 and 180.
        Validator::extend('latitude', function ($attribute, $value, $parameters, $validator) {
            //
            // The latitude is always between -90 and 90.
            //
            return ($value >= -90 && $value <= 90);
        });

        Validator::extend('longitude', function ($attribute, $value, $parameters, $validator) {
            //
            // The longitude is always between -180 and 180.
            //
            return ($value >= -180 && $value <= 180);
        });

        Validator::extend('name_title', function ($attribute, $value, $parameters, $validator) {
            if ($value === null) {
                return false;
            }

            return ! preg_match("#[^-A-Za-z0-9,.&(): ']+#", $value);
        });
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
