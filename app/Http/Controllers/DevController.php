<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Client;
use App\Project;
use App\UserRole;
use App\Http\Requests;
use Illuminate\Support\Facades\Validator;
use File;
use GuzzleHttp;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Exception\ClientException;
use PolygonParser;

class DevController extends Controller
{

    /**
     * users
     *
     */
    public function users()
    {
        $users = User::with('client')->get();
        return view('dev.users', ['users' => $users]);
    }

    /**
     * clients
     *
     */
    public function clients()
    {
        $clients = Client::orderBy('id', 'ASC')->get();
        return view('dev.clients', ['clients' => $clients]);
    }

    public function client($uniq_id)
    {
        $client = Client::where('uniq_id', '=', $uniq_id)->first();
        $wildcard_domain = env('WILDCARD_DOMAIN');

        return view('dev.one-client',
            [
                'client' => $client
            ]
        );
    }

    public function scannerToggle($user_uniq_id, $project_uniq_id)
    {
        $data = compact('user_uniq_id', 'project_uniq_id');

        $validator = Validator::make(
            $data, [
                'user_uniq_id' => 'uuid',
                'project_uniq_id' => 'uuid'
            ]
        );

        if ($validator->fails()) {
            return "Invalid UUID format";
        }

        $user   = User::where('uniq_id', '=', $user_uniq_id)->getClean();

        $url = env('APP_SCHEME') . '://' . $user->client->subdomain . '.' . env('WILDCARD_DOMAIN') . '/api/v1.0/webapp/check/scanner/toggle';
        $token = $this->getOauth2Token($url, ['username' => $user->username, 'pwd' => 'abc123456']);
        $guzzle = new GuzzleHttp\Client();

        try {
            $res = $guzzle->post(
                $url,
                [
                    'headers' => [
                        'Authorization' => 'Bearer ' . $token,
                        'Content-type' => 'application/json',
                        'Accept' => 'application/json',
                    ],
                    'json' => [
                        'user_uniq_id' => $user_uniq_id,
                        'project_uniq_id' => $project_uniq_id
                    ]
                ]
            );
        } catch (\Exception $e) {
            return $e->getMessage();
        }

        // echo $res->getStatusCode();
        // die($res->getBody());

        return redirect('/dev/user/' . $user_uniq_id . '/#toggle');
    }

    public function user($uniq_id)
    {
        $user = User::where('uniq_id', '=', $uniq_id)->getClean();

        if (!$user) {
            return abort(404);
        }

        $userRole = new UserRole($user);
        $email64 = base64_encode($user->email . ':' . 'abc123456');
        $phone64 = base64_encode($user->mobileNumber. ':' . 'abc123456');
        $username64 = base64_encode($user->username . ':' . 'abc123456');

        $wildcard_domain = env('WILDCARD_DOMAIN');
        $projectUrl = "http://{$user->client->subdomain}.{$wildcard_domain}/api/v1.0/projects";

        return view('dev.one-user',
            [
                'user' => $user,
                'userRole' => $userRole,
                'projectUrl' => $projectUrl,
                'email64' => $email64,
                'phone64' => $phone64,
                'username64' => $username64,
            ]
        );
    }

    public function project($uniq_id)
    {
        $project = Project::where('uniq_id', '=', $uniq_id)->first();
        $wildcard_domain = env('WILDCARD_DOMAIN');

        return view('dev.project',
            [
                'project' => $project,
            ]
        );

    }

    /**
     * swagger
     *
     */
    public function swagger()
    {
        $json = json_decode(File::get(base_path('docs/swagger/punchcardv10.json')));
        //die(json_encode($json,JSON_PRETTY_PRINT));
        return response()->json($json);
    }



    protected function getOauth2Token($url, $auth)
    {
        $data = [
            "grant_type" => "password",
            "client_id" => env('TEST_API_CLIENT_ID'),
            "client_secret" => env('TEST_API_CLIENT_SECRET'),
            "username" => $auth['username'],
            "password" => $auth['pwd'],
            "scope" => "*"
        ];

        $urlParts = parse_url($url);

        $guzzle = new GuzzleHttp\Client();

        $meta = [
            'headers' => [
                'CONTENT_TYPE' => 'application/json',
                'HTTP_CONTENT_TYPE' => 'application/json',
                'HTTP_ACCEPT' => 'application/json'
            ],
            'json' => $data
        ];

        $response = $guzzle->request(
            'POST',
            $urlParts['scheme'] . '://' . $urlParts['host'] . '/api/v1.0/oauth/token',
            $meta
        );

        $json = json_decode((string)$response->getBody());

        return $json->access_token;
    }
}
