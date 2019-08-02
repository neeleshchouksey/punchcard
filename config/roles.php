<?php

return [
    'all' => [
        'user',
        'superuser',
        'admin',
        'clientadmin',
        'superadmin'
    ],

    'at_least' => [
        'user' => [
            'user', 'superuser', 'admin', 'clientadmin', 'superadmin'
        ],
        'superuser' => [
            'superuser', 'admin', 'clientadmin', 'superadmin'
        ],
        'admin' => [
            'admin', 'superadmin', 'clientadmin'
        ],
        'clientadmin' => [
            'superadmin', 'clientadmin'
        ],
        'superadmin' => [
            'superadmin'
        ],
    ],
];
