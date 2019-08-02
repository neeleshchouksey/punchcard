<?php namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class SearchProjectUsersRemoved
{
    use InteractsWithSockets, SerializesModels;

    public $projectUser;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($projectUser)
    {
        $this->projectUser = $projectUser;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('channel-name');
    }
}
