<?php namespace App\Webapp\Clients;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Model;
use App\Traits\UniqIdTrait;
use App\Client;

//
// Allows adding subdomains for use with imports and superadmin capabilities
// Does not extend Client!
//
class Add extends Model
{
    use UniqIdTrait;
    use SoftDeletes;

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];
    protected $table = 'clients';

    protected $casts = [
         'jdoc' => 'array',
    ];

    protected $fillable = [
        'child_of_id',
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
        'jdoc',
        'plan_test',
        'facelistid'
    ];

    protected $hidden = [
        'created_at', 'updated_at', 'deleted_at'
    ];

    public static function create(array $data = [])
    {
        $data['subdomain'] = strtolower($data['subdomain']);
        return parent::create($data);
    }

    public function setPhoneAttribute($value)
    {
        $this->attributes['phone'] = preg_replace('#[^0-9]+#', '', $value);
    }

    public function setFaxAttribute($value)
    {
        $this->attributes['fax'] = preg_replace('#[^0-9]+#', '', $value);
    }

    public function users()
    {
        return $this->hasMany('App\User', 'client_id', 'id');
    }

    public function getSubdomainAttribute()
    {
        if ($this->child_of_id == 0) {
            return $this->attributes['subdomain'];
        }

        $parentClient = static::find($this->child_of_id);
        $subdomain = strtolower($parentClient->attributes['subdomain']);

        return $subdomain;
    }

    public function projects()
    {
        return $this->hasMany('App\Project', 'client_id', 'id');
    }

    public function children()
    {
        return $this->hasMany('App\Client', 'child_of_id', 'id');
    }

    public function parent()
    {
        return $this->belongsTo('App\Client', 'child_of_id', 'id');
    }

    public function getLogoAttribute()
    {
        //return env('APP_URL') . '/api/v1.0/clients/logo/' . $this->uniq_id;
        return '/api/v1.0/clients/logo/' . $this->uniq_id;
    }

    public function scopeWhereSubdomain($query, $subdomain)
    {
        return $query->where('subdomain', strtolower($subdomain));
    }

    public function scopeWhereActive($query)
    {
        return $query->where('status', 'active');
    }
}
