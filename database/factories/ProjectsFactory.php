<?php

use App\ProjectPolyFence;

$factory->define(App\Project::class, function (Faker\Generator $faker) {

    //
    // lat/long here are the "gate"
    //
    $start_end_lat = $latitude  = $faker->latitude(30, 37);
    $start_end_long= $longitude = $faker->longitude(-96, -81);

    $polyFence = new ProjectPolyFence([$start_end_lat, $start_end_long], 5, .02);
    $polyFence->create();

    return [
        'uniq_id' => $faker->uuid,
        'name' => $faker->company,
        'description' => substr($faker->paragraph, 0, 250),
        'address' => $faker->streetAddress,
        'city' => $faker->city,
        'state' => $faker->stateAbbr,
        'zip' => $faker->postcode,
        'county' => $faker->city . ' Co',
        'country' => 'US',
        'sector_id' => 1,
        'industry_id' => 1,
        'pointfence' => "({$latitude},{$longitude})",
        'latitude' => $latitude,
        'longitude' => $longitude,
        'radius' => mt_rand(100, 10000),
        'polyfence' => $polyFence->retrieveAsDbInsertableString(),
        'startDate' => $faker->dateTimeThisMonth(),
        'endDate' => $faker->dateTimeBetween('now', '+3 months'),
        'status' => $faker->randomElement(['active', 'inactive'])
    ];
});
