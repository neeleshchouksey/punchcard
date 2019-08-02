<?php namespace App\Webapp\Projects;

use App\Exceptions\BadInputException;
use Storage;
use App\Store\Store;

/**
 * Store the project's uploaded logo
 *
 * @author Hans Anderson <me@hansanderson.com>
 */
class StoreLogo extends Store
{
    protected $disk = 'project-logos';
}
