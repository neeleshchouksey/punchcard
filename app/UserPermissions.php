<?php namespace App;

use DB;
use Log;
use Request;
use App\User;

class UserPermissions extends User
{
    protected $table = 'users';

    public function hasPermission($key, $id)
    {
        if (!$id) {
            return false;
        }

        $permissions = $this->permissions;

        if (!is_array($permissions) && !is_object($permissions)) {
            $permissions = json_decode($permissions, true);
        }

        if (! isset($permissions[$key])) {
            return false;
        }

        return in_array($id, $permissions[$key]);
    }

    public function permissionAdd($key, $id)
    {
        $id = $this->forceInt($id);

        if (! isset($this->permissions[$key])) {
            $value = [];
        } else {
            $value = $this->permissions[$key];
        }

        if (! is_array($value)) {
            return false;
        }

        $value[] = $id;

        $value = array_unique($value);

        return $this->updateArrayPermission($key, $value);
    }

    public function permissionRemove($key, $id)
    {
        $id = $this->forceInt($id);

        if (! isset($this->permissions[$key])) {
            return false;
        }

        $value = $this->permissions[$key];

        if (! is_array($value)) {
            return false;
        }

        $found = array_search($id, $value);

        if ($found !== false) {
            unset($value[$found]);
        }

        $value = array_unique($value);

        $this->updateArrayPermission($key, $value);
    }

    public function updateArrayPermission($permission, $value)
    {
        if (!$this->id) {
            return false;
        }

        if (is_array($value) || is_object($value)) {
            $value = json_encode(array_values($value));
        }

        // 2nd field can be a comma-delimited list, eg:
        // instead of scanner->foo->bar
        // scanner,foo,bar <-- Postgres speak
        // jsonb_set(field, path, new_value, boolean "create missing" default true)

        if (!sizeof($this->permissions) or empty($this->permissions)) { // the update won't work unless we at least have {}
            DB::update("UPDATE users SET permissions = '{}' WHERE id = ?", [$this->id]);
        }

        Log::info('PERM ' . $permission . print_r($value, true));

        DB::update("UPDATE users
                    SET permissions = jsonb_set(permissions, '{" . $permission . "}', '" . $value . "'::jsonb)
                    WHERE id = ?", [$this->id]);

        return $this;
    }
}
