<?php

namespace App\Providers;

use DB;
use Illuminate\Support\Str;
use Illuminate\Contracts\Auth\UserProvider;
use Illuminate\Database\ConnectionInterface;
use Illuminate\Auth\GenericUser;
use App\User;
use Illuminate\Contracts\Hashing\Hasher as HasherContract;
use Illuminate\Contracts\Auth\Authenticatable as UserContract;

class InverseUserProvider implements UserProvider
{
    /**
     * The active database connection.
     *
     * @var \Illuminate\Database\ConnectionInterface
     */
    protected $conn;

    /**
     * The hasher implementation.
     *
     * @var \Illuminate\Contracts\Hashing\Hasher
     */
    protected $hasher;

    /**
     * The table containing the users.
     *
     * @var string
     */
    protected $table;

    /**
     * Create a new database user provider.
     *
     * @param  \Illuminate\Database\ConnectionInterface  $conn
     * @param  \Illuminate\Contracts\Hashing\Hasher  $hasher
     * @param  string  $table
     * @return void
     */
    public function __construct(ConnectionInterface $conn, HasherContract $hasher, $table)
    {
        $this->conn = $conn;
        $this->table = $table;
        $this->hasher = $hasher;
    }

    /**
     * Retrieve a user by their unique identifier.
     *
     * @param  mixed  $identifier
     * @return \Illuminate\Contracts\Auth\Authenticatable|null
     */
    public function retrieveById($identifier)
    {
        $user = $this->conn->table($this->table)->find($identifier);

        return $this->getGenericUser($user);
    }

    /**
     * Retrieve a user by their unique identifier and "remember me" token.
     *
     * @param  mixed  $identifier
     * @param  string  $token
     * @return \Illuminate\Contracts\Auth\Authenticatable|null
     */
    public function retrieveByToken($identifier, $token)
    {
        $user = $this->conn->table($this->table)
            ->where('id', $identifier)
            ->where('remember_token', $token)
            ->first();

        return $this->getGenericUser($user);
    }

    /**
     * Update the "remember me" token for the given user in storage.
     *
     * @param  \Illuminate\Contracts\Auth\Authenticatable  $user
     * @param  string  $token
     * @return void
     */
    public function updateRememberToken(UserContract $user, $token)
    {
        $this->conn->table($this->table)
                ->where('id', $user->getAuthIdentifier())
                ->update(['remember_token' => $token]);
    }

    /**
     * Retrieve a user by the given credentials.
     *
     * @param  array  $credentials
     * @return \Illuminate\Contracts\Auth\Authenticatable|null
     */
    public function retrieveByCredentials(array $credentials)
    {
        #$credentials = $this->rearrangCredentialsIfNeccessary($credentials);
        return (new User)->retrieveForPasswordReset($credentials);


        // return User::join('clients AS c', 'users.client_id', '=', 'c.id')
        //     ->where('users.' . $credentials['field'] . '', '=', $credentials['value'])
        //     ->where('users.status', '=', 'active')
        //     ->where('c.status', '=', 'active')
        //     ->where('c.subdomain', '=', $credentials['subdomain'])
        //     ->select(['users.*'])
        //     ->first();
    }

    /**
     * Get the generic user.
     *
     * @param  mixed  $user
     * @return \Illuminate\Auth\GenericUser|null
     */
    protected function getGenericUser($user)
    {
        if ($user !== null) {
            return new GenericUser((array) $user);
        }
    }

    /**
     * Validate a user against the given credentials.
     *
     * @param  \Illuminate\Contracts\Auth\Authenticatable  $user
     * @param  array  $credentials
     * @return bool
     */
    public function validateCredentials(UserContract $user, array $credentials)
    {
        $plain = $credentials['password'];

        return $this->hasher->check($plain, $user->getAuthPassword());
    }

    protected function rearrangCredentialsIfNeccessary($credentials)
    {
        if (!isset($credentials['field']) && isset($credentials['email'])) {
            $credentials['field'] = 'email';
            $credentials['value'] = $credentials['email'];
            $credentials['subdomain'] = $this->getRequestSubdomain();
        }

        return $credentials;
    }

    protected function getRequestSubdomain()
    {
        list($subdomain,) = explode('.', $_SERVER['HTTP_HOST']);
        $subdomain = strtolower($subdomain);

        return $subdomain;
    }
}
