<?php

$factory->define(App\Client::class, function (Faker\Generator $faker) {
    // static $alphaIncrementer = 'a';
    // $subdomain = 'company' . $alphaIncrementer;
    // $alphaIncrementer++;
    //$random = 'subdomain-' . $faker->word . '-' . $faker->randomNumber(4);

    $name = $faker->company;
    $subdomain = preg_replace('#[^-_0-9a-zA-Z]#', '', strToLower($name)) . $faker->randomNumber(4);
    $phone = (string)'7775' . mt_rand(200000,999999);
    $fax   = (string)'5855' . mt_rand(200000,999999);

    return [
        'name' => $name,
        'uniq_id' => $faker->uuid,
        'subdomain' => $subdomain,
        'fein' => $faker->isbn10,
        'dba' => $name . ' (dba)',
        'address' => $faker->streetAddress,
        'city' => $faker->city,
        'state' => $faker->stateAbbr,
        'zip' => $faker->postcode,
        'phone' => $phone,
        'fax' => $fax,
        'website' => 'http://example.org',
        'status' => $faker->randomElement(['active', 'inactive'])
    ];
});
