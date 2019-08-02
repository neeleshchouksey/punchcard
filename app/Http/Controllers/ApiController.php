<?php namespace App\Http\Controllers;

abstract class ApiController extends Controller
{
    protected function respondWithJsonPagination ($data)
    {

        $returnData = $data->toArray();

        if ($returnData['total']) {
            $msg = "{$returnData['total']} results, showing page {$returnData['current_page']} of {$returnData['last_page']}" ;
        } else {
            $msg = "{$returnData['total']} results";
        }

        $returnData['result']    = 'success';
        $returnData['message']   = $msg;
        $returnData['http_code'] = 200;
        return response()->json($returnData, 200, array(), JSON_PRETTY_PRINT);
    }

    protected function respondWithJsonPaginationForClients ($data)
    {
        $returnData = $data;
        if ($returnData['total']) {
            $msg = "{$returnData['total']} results, showing page {$returnData['current_page']} of {$returnData['last_page']}" ;
        } else {
            $msg = "{$returnData['total']} results";
        }

        $returnData['result']    = 'success';
        $returnData['message']   = $msg;
        $returnData['http_code'] = 200;
        return response()->json($returnData, 200, array(), JSON_PRETTY_PRINT);
    }


    protected function jsonSuccess($message, $data = null)
    {
        if ($data === null) {
            $data = new \StdClass;
        }

        return response()->json([
            "result" => 'success',
            "message" => $message,
            "http_code" => 200,
            "data" => $data
        ], 200, array(), JSON_PRETTY_PRINT);
    }

    protected function jsonDenied($message, $data = null)
    {
        if ($data === null) {
            $data = new \StdClass;
        }

        return response()->json([
            "result" => 'error',
            "message" => $message,
            "http_code" => 403,
            "data" => $data
        ], 403, array(), JSON_PRETTY_PRINT);
    }

    protected function jsonFailure($message, $data = null)
    {
        return $this->failureResponse($message, $data, 422);
    }

    protected function jsonNotFound($message, $data = null)
    {
        return $this->failureResponse($message, $data, 404);
    }

    protected function failureResponse($message, $data, $code)
    {
        if ($data === null) {
            $data = new \StdClass;
        } else if (is_array($data) && !sizeof($data)) {
            $data = new \StdClass;
        }

        return response()->json([
            "result" => 'error',
            "message" => $message,
            "http_code" => $code,
            "data" => $data
        ], $code, array(), JSON_PRETTY_PRINT);
    }
}
