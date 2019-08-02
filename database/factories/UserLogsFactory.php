<?php

$factory->define(App\UserLog::class, function (Faker\Generator $faker) {
    return [
        'uniq_id' => $faker->uuid,
        'dateTime' => $faker->dateTimeBetween('-20 day', '+1 day'),
        'note' => $faker->paragraph,
        'type' => $faker->randomElement(['general', 'punch in exception', 'punch out exception'])
    ];
});
