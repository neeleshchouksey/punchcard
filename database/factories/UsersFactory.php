<?php
$factory->define(App\User::class, function (Faker\Generator $faker) {
    static $password;

    $phoneNumber = (string)'5557' . mt_rand(200000, 999999);
    $pay_rate    = $faker->numberBetween(15, 35);

    $jdoc =<<<EOFJSON
{

    "department": "{$faker->word}",
    "trade": "{$faker->word}",
    "job_title": "{$faker->jobTitle}",
    "homeNumber": "{$phoneNumber}",
    "workNumber": "{$phoneNumber}",
    "middleName": "N.",

    "address": {
        "address1": "{$faker->streetAddress}",
        "address2": "{$faker->streetAddress}",
        "city": "{$faker->city}",
        "state": "{$faker->state}",
        "zip": "{$faker->postcode}"
    },

    "vehicle": {
        "driversLicenseNumber": "{$faker->swiftBicNumber}",
        "driversLicenseState": "{$faker->stateAbbr}",
        "carMake": "Ford",
        "carModel": "F150",
        "licPlateNumber": "123-4576",
        "licPlateState": "NC"
    },

    "emerContact": {
        "name": "{$faker->firstName}",
        "relation": "spouse",
        "homeNumber": "{$phoneNumber}",
        "mobileNumber": "{$phoneNumber}",
        "workNumber": "{$phoneNumber}",
        "email": "{$faker->email}"
    },

    "payroll_data": {
        "pay_rate": {$pay_rate}
    }
}
EOFJSON;

    $first_name = $faker->firstName;
    $last_name  = $faker->lastName;
    $username   = preg_replace('#[^0-9A-Za-z]*#', '', $first_name . $last_name);

    return [
        'uniq_id' => $faker->uuid,
        'first_name' => $first_name,
        'last_name' => $last_name,
        'email' => $username . '@inverseapp.today',
        'username' => $username,
        'mobileNumber' => preg_replace('#[^0-9]#', '', $faker->tollFreePhoneNumber),
        'password' => $password ?: $password = bcrypt('abc123456'),
        'status' => $faker->randomElement(['active', 'inactive']),
        'role' => $faker->randomElement(['user', 'user', 'superuser', 'admin', 'clientadmin']),
        'jdoc' => json_decode(trim($jdoc)),
        'remember_token' => str_random(10),
    ];
});
