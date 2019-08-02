<?php
$factory->define(App\Report::class, function (Faker\Generator $faker) {

    //
    // a factory will need to create the report_number and name
    //
    return [
        'uniq_id' => $faker->uuid,
        'report_number' => '',
        'name' => '',
        'jdoc' => ''
    ];
});
