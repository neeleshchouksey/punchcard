<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Permissions extends Model
{
    protected $hidden = ['pivot', 'created_at', 'updated_at'];
}
