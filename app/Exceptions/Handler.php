<?php

namespace App\Exceptions;

use App;
use Log;
use Exception;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException;
use \Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use \Symfony\Component\HttpKernel\Exception\HttpException;
use \Illuminate\Auth\Access\AuthorizationException;

class Handler extends ExceptionHandler
{
    /**
     * A list of the exception types that should not be reported.
     *
     * @var array
     */
    protected $dontReport = [
        \Illuminate\Auth\AuthenticationException::class,
        \Illuminate\Auth\Access\AuthorizationException::class,
        \Symfony\Component\HttpKernel\Exception\HttpException::class,
        \Illuminate\Database\Eloquent\ModelNotFoundException::class,
        \Illuminate\Session\TokenMismatchException::class,
        \Illuminate\Validation\ValidationException::class,
    ];

    /**
     * Report or log an exception.
     *
     * This is a great spot to send exceptions to Sentry, Bugsnag, etc.
     *
     * @param  \Exception  $exception
     * @return void
     */
    public function report(Exception $exception)
    {
        parent::report($exception);
    }

    /**
     * Render an exception into an HTTP response.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Exception  $exception
     * @return \Illuminate\Http\Response
     */
    public function render($request, Exception $exception)
    {
        if ($request->expectsJson()) {
            if ($exception instanceof HttpException) {
                switch ($exception->getStatusCode()) {
                    case 404:
                        return $this->renderJsonNotFound($exception);
                        break;

                    case 405:
                        return $this->renderJsonMethodNotPermitted($exception);
                        break;
                }
            }

            if ($exception instanceof NotFoundHttpException) {
                return $this->renderJsonNotFound($exception);
            }

            if ($exception instanceof \Symfony\Component\HttpKernel\Exception\NotFoundHttpException) {
                return $this->renderJsonNotFound($exception);
            }

            if ($exception instanceof MethodNotAllowedHttpException) {
                return $this->renderJsonMethodNotPermitted($exception);
            }

            if ($exception instanceof \Illuminate\Validation\ValidationException) {
                //dd($exception->validator->getMessageBag());

                $errors = $exception->validator->getMessageBag()->toArray();

                $ret = [];
                foreach ($errors as $error) {
                    $ret[] = $error[0];
                }

                $message = implode(', ', array_values($ret));

                return $this->renderJsonBadInput($message);
            }

            if ($exception instanceof BadInputException) {
                return $this->renderJsonBadInput($exception->getMessage());
            }

            if ($exception instanceof BadInputUnknownFieldsException) {
                return $this->renderJsonBadInput($exception->getMessage());
            }

            if ($exception instanceof \Illuminate\Database\QueryException) {
                return $this->renderJsonBadQuery($exception);
            }

            if ($exception instanceof AuthorizationException) {
                return $this->renderJsonNotAuthorized($exception);
            }
        }

        return parent::render($request, $exception);
    }

    protected function renderJsonNotFound($exception)
    {
        return $this->renderJson('error', 'The endpoint was not found or the uniq_id was not a valid UUID.', 404);
    }

    protected function renderJsonNotAuthorized($exception)
    {
        return $this->renderJson('error', '' . $exception->getMessage(), 403);
    }

    protected function renderJsonMethodNotPermitted($exception)
    {
        $msg = trim('Method not permitted for endpoint ' . $exception->getMessage());
        return $this->renderJson('error', $msg, 405);
    }

    protected function renderJsonBadInput($exceptionMsg, $exceptionData = null)
    {
        
        return $this->renderJson('error', $exceptionMsg, 422, $exceptionData);
    }

    protected function renderJsonBadQuery($exception)
    {
        $msg = $exception->getMessage();
        Log::error($msg);
        $outMsg = stripos($msg, 'unique constraint') !== false ? ' Likely duplicate records.' : '';
        return $this->renderJson('error', 'The Subdomain has already been taken.', 422);
    }

    protected function renderJson($result, $message, $http_code, $data = null)
    {
        if ($data === null) {
            $data = new \StdClass;
        }

        return response()->json([
            'result' => $result,
            'message' => $message,
            'http_code' => $http_code,
            'data' => $data
        ], $http_code, array(), JSON_PRETTY_PRINT);
    }

    /**
     * Convert an authentication exception into an unauthenticated response.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Illuminate\Auth\AuthenticationException  $exception
     * @return \Illuminate\Http\Response
     */
    protected function unauthenticated($request, AuthenticationException $exception)
    {
        if ($request->expectsJson()) {
            return response()->json(['error' => 'Unauthenticated.'], 401);
        }

        return App::abort(401, 'Unauthorized');
    }
}
