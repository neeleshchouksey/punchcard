<?php namespace App\Webapp\Clients;

use Illuminate\Database\Eloquent\Model;
use App\Webapp\Clients\Add as ClientAdd;

//
// Allows adding subdomains for use with imports and superadmin capabilities
// Does not extend Client!
//
class Update extends ClientAdd
{
    protected $dates = ['deleted_at'];
    protected $table = 'clients';

    protected $fillable = [
        'subdomain',
        'name',
        'fein',
        'dba',
        'address',
        'city',
        'state',
        'zip',
        'phone',
        'fax',
        'website',
        'status',
        'jdoc'
    ];

    public function update(array $data = [], array $options = [])
    {
        //$data['subdomain'] = strtolower($data['subdomain']);
        return parent::update($data, $options);
    }
}
