<?php namespace App\Http\Requests;

use App\Exceptions\BadInputUnknownFieldsException;
use Illuminate\Foundation\Http\FormRequest;
use Request;
use Illuminate\Http\JsonResponse;

class ApiRequest extends FormRequest
{
    protected $errorMsg = [];

    public function validate()
    {
        /**
         * Pre-check to make sure only the fields we expect are here.
         * This doesn't check for missing fields, but EXTRA fields
         */

        switch (Request::method()) {
            case 'POST':
            case 'PUT':
                $data = json_decode(Request::getContent(), true);
                break;

            default:
                $data  = $this->request->all();
                break;
        }

        $invalidFields = $this->checkForInvalidFields($this->rules(), $data);

        if (sizeof($invalidFields)) {
            throw new BadInputUnknownFieldsException('Unknown fields: ' . implode(', ', $invalidFields));
        }

        parent::validate();
    }

    protected function checkForInvalidFields($rules, $data)
    {
        if (! is_array($data) or ! sizeof($data)) {
            return [];
        }

        $invalidFields = [];

        foreach ($data as $field => $toss) {
            if (! isset($rules[$field])) {
                $invalidFields[] = $field;
            }
        }

        return $invalidFields;
    }

    //
    // Overrides the less helpful Laravel version
    //
    public function forbiddenResponse()
    {
        $data = new \StdClass;
        return new JsonResponse(
            [
                "result" => 'error',
                "message" => implode(', ', $this->errorMsg),
                "http_code" => 422,
                "data" => $data
            ],
            422
        );
	
    }

    public function getErrorMsg()
    {
        return $this->errorMsg;
    }
}
