<?php namespace App\Webapp\Clients;

#use ClientWebapp;
use App\User;
use Illuminate\Http\Request;

class PermittedToAccess
{
    protected $inRequest;
    protected $inUser;
    protected $columns = ['*'];

    public function __construct(Request $request, AccessInterface $authUser)
    {
        $this->inRequest = $request;
        $this->inUser = $authUser;
    }

    public function setColumns($columns = ['*'])
    {
        $this->columns= $columns;
        return $this;
    }

    public function remove($uniq_id)
    {
        return $this->inUser->remove($uniq_id);
    }

    public function getClient($uniq_id)
    {
        $as = $this->inUser->getOne($uniq_id);

        if (!$as) {
            return null;
        }

        return $as->select($this->columns)->first();
    }

    public function getManyClients($paginated = true)
    {
        $as = $this->inUser->getMany();

        if (!$as) {
            return null;
        }

        if ($paginated) {
            return $as->select($this->columns)->paginate($this->inRequest->query('per_page', 9999));
        } else {
            return $as->select($this->columns)->get();
        }
    }

    public function getManyClientsForExport()
    {
        $as = $this->inUser->getManyForExport();

        if (!$as) {
            return null;
        }

        return $as->select(['*'])->get();
    }
}
