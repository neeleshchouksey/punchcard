<?php

namespace App\Http\Controllers;

use App\SearchProjectsUsers;
use App\Project;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests;
use App\User;
use Illuminate\Pagination\LengthAwarePaginator as Paginator;

class SearchController extends ApiController
{
    public function projects(Request $request, $uniq_id)
    {
        $term  = $request->input('q');
        $limit = $request->input('n', 15);
        $page  = $request->input('page', 1);

        $project = Project::where('uniq_id', $uniq_id)->first();

        if (! $project) {
            return $this->jsonDenied('Denied access to project or project not found');
        }

        $searchResults = SearchProjectsUsers::search($term)->get();

        //$filteredResults = $searchResults->filter(function ($item, $key) use ($project) {
        $filteredResults = $searchResults->map(function ($item, $key) use ($project) {

            if ($item->project_id <> $project->id) {
                return ;
            }

            if ($this->viewerIsAChildCompanyUserButThisIsParentCompanyUser($item)) {
                return ;
            }

            $user = User::where('id', $item->user_id)
                ->select('uniq_id', 'id', 'first_name', 'last_name')
                ->first();

            $user->addOnsite($item->project_id);
            $user->addLastChecks($item->project_id);
            return $user;
/*
            $item->user_uniq_id = $item->user->uniq_id;
            $item->user_name = $item->user->name;
            $item->mobileNumber = $item->user->mobileNumber;
            $item->licPlateNumber = $item->user->jdoc['vehicle']['licPlateNumber'];

            $item->client_id = $item->user->client->id;
            $item->client_uniq_id = $item->user->client->uniq_id;
            $item->client_name = $item->user->client->name;

            $item->project_name = $item->project->name;
            $item->project_uniq_id = $item->project->uniq_id;

            $item->badge_id = $item->id;
            unset($item->id);
            unset($item->user_id);
            unset($item->project);
            unset($item->user);
 */

//            return true;
        });

        $filteredResults = $filteredResults->filter()->all();

        $total = sizeof($filteredResults);
        //$thisPageResults = array_slice($filteredResults->toArray(), ($limit * ($page-1)), $limit);
        $thisPageResults = array_slice($filteredResults, ($limit * ($page-1)), $limit);


        $paginatedResults = new Paginator($thisPageResults, (int)$total, (int)$limit, (int)$page, [
            'path'  => $request->url(),
            'query' => $request->query(),
        ]);
        return $this->respondWithJsonPagination($paginatedResults);
    }

    protected function viewerIsAChildCompanyUserButThisIsParentCompanyUser($item)
    {
        //
        // A parent company viewing user can see all
        // A child company viewing user can see only their own users
        //
        // part of a parent company
        //
        if (Auth::user()->client->child_of_id == 0) {
            return false;
        }

        //
        // If this far, viewing user is a child company user
        //
        // same company
        //
        if (Auth::user()->client->id == $item->user->client->id) {
            return false;
        }


        return true; // default: we'll skip this user
    }
}
