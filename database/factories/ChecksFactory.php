<?php

use App\Project;

$factory->define(App\Check::class, function (Faker\Generator $faker) {

    return [
        'uniq_id' => $faker->uuid,
        'checkInDateTime' => $faker->dateTimeBetween('now', '+1 day'),
        'checkOutDateTime' => $faker->dateTimeBetween('+1 day', '+2 day'),
        'longitudeIn' => $faker->longitude,
        'latitudeIn' => $faker->latitude,
        'longitudeOut' => $faker->longitude,
        'latitudeOut' => $faker->latitude,
        'isExceptionIn' => false,
        'isExceptionOut' => false,
        'checkMethod' => $faker->randomElement(['geo', 'geo', 'geo', 'geo', 'qr', 'manual'])
    ];
});
