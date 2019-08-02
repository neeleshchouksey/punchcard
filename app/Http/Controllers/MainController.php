<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Request as RequestServer;

class MainController extends Controller
{

    public function vue(Request $request)
    {
        $parts = explode('.', RequestServer::server('HTTP_HOST'));

        if ((sizeof($parts) < 3 or $parts[0] === 'www') && !$request->input('subdomain')) {
            return view('enter-subdomain');
        }

        return view('welcome');
    }

    public function subdirect(Request $request)
    {
        
        $subdomain = $request->input('subdomain');
        $subdomain = strtolower($subdomain);
        $subdomain = preg_replace('#[^-_a-z0-9]#', '', $subdomain);
	// $subdomain="ihos";
        $host = $this->getDomain();

        return redirect(env('APP_SCHEME') . '://' . $subdomain . '.' . $host);
    }

    public function index(Request $request)
    {
        return response()->json([
            "name" => "Punchcard App API v1.0",
            "website" => "https://punchcardllc.com/",
            "help_message" => "For version 1.0, valid endpoints start with: /api/v1.0/; use Basic auth over SSL",
            "data_type" => "Supported: json; Content-type: `application/json` required"
        ], 200, array(), JSON_PRETTY_PRINT);
    }

    protected function getDomain()
    {
        $parts = explode('.', RequestServer::server('HTTP_HOST'));

        if (sizeof($parts) < 3) {
            return implode('.', $parts);
        }

        return implode('.', array_slice($parts, -2));
    }
}
