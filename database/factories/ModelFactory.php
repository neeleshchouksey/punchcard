<?php

/*
|--------------------------------------------------------------------------
| Model Factories
|--------------------------------------------------------------------------
|
| Here you may define all of your model factories. Model factories give
| you a convenient way to create models for testing and seeding your
| database. Just tell the factory how a default model should look.
|
*/

$factory->define(App\Sector::class, function (Faker\Generator $faker) {
    return [
        'name' => 'Sector: ' . $faker->text(24)
    ];
});

$factory->define(App\Industry::class, function (Faker\Generator $faker) {
    return [
        'name' => 'Industry: ' . $faker->text(24)
    ];
});

$factory->define(App\ProjectUser::class, function (Faker\Generator $faker) {
    //
    // These should be overridden by seeding input
    //
    return [
        'user_id' => $faker->randomNumber,
        'project_id' => $faker->randomNumber
    ];
});

$factory->define(App\ClientProject::class, function (Faker\Generator $faker) {
    //
    // These should be overridden by seeding input
    //
    return [
        'client_id' => $faker->randomNumber,
        'project_id' => $faker->randomNumber
    ];
});
