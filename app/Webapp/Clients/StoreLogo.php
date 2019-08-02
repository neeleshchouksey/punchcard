<?php namespace App\Webapp\Clients;

use App\Exceptions\BadInputException;
use Storage;
use App\Store\Store;

/**
 * Store the client's uploaded logo
 *
 * @author Hans Anderson <me@hansanderson.com>
 */
class StoreLogo extends Store
{
    protected $disk = 'logos';
}
