<?php namespace App\Listeners;

use App\Events\SearchProjectUsersRemoved;
use Illuminate\Queue\InteractsWithQueue;
use App\System\CheckOut;
use Illuminate\Contracts\Queue\ShouldQueue;


class CheckUserOutOnProjectUserRemove
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * When the user is removed from a project, we
     * need to ensure they are checked out of the
     * project as well.
     *
     * @param  SearchProjectUsersRemoved  $event
     * @return void
     */
    public function handle(SearchProjectUsersRemoved $event)
    {
        $systemCheckOut = new CheckOut;
        $systemCheckOut->forceOut([
            'user_id' => $event->projectUser->user_id,
            'project_id' => $event->projectUser->project_id
        ]);
    }
}
