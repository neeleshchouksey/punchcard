<?php namespace App;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Model;
use App\Traits\UniqIdTrait;
use App\Traits\SubdomainTrait;
use DB;

class Client extends Model
{
    use UniqIdTrait, SubdomainTrait;
    use SoftDeletes;

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];

    protected $casts = [
         'jdoc' => 'array',
    ];

    protected $fillable = [
        'child_of_id',
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
        'created_at',
        'plan_test',
        'creditCardDeactivateDate',
        'unsubscribedDate',
        'suscribedDate'
    ];

    protected $hidden = [
        'updated_at', 'deleted_at'
    ];

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

    public function updateJdoc($field, $value)
    {
        if (!$this->id) {
            return false;
        }

        if (is_array($value) || is_object($value)) {
            $value = json_encode($value);
        }

        if (!sizeof($this->jdoc) or empty($this->jdoc)) { // the update won't work unless we at least have {}
            DB::update("UPDATE clients SET jdoc = '{}' WHERE id = ?", [$this->id]);
        }

        DB::update("UPDATE clients
                    SET jdoc = jsonb_set(jdoc, '{" . $field . "}', '" . $value . "'::jsonb)
                    WHERE id = ?", [$this->id]);

        return $this;
    }

    protected function getArrayKey($data)
    {
        return md5(serialize($data));
    }

    public function addContact($data)
    {
        if (isset($this->jdoc['contacts'])) {
            $contacts = $this->jdoc['contacts'];
        } else {
            $contacts = [];
        }

        if (! is_array($contacts)) {
            return false;
        }

        $key = $this->getArrayKey($data);
        $contacts[$key] = $data;
        $this->updateJdoc('contacts', $contacts);

        return $contacts;
    }

    public function removeContact($id)
    {
        if (! isset($this->jdoc['contacts'])) {
            return [];
        }

        $contacts = $this->jdoc['contacts'];

        if (! is_array($contacts)) {
            return [];
        }

        unset($contacts[$id]);
        $this->updateJdoc('contacts', $contacts);

        return $contacts;
    }
}
