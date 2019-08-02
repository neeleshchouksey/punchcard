<?php namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class RegistrationConfirmation extends Notification
{
    use Queueable;

    protected $token;
    protected $user;

    public function __construct($user, $token)
    {
        $this->user  = $user;
        $this->token = $token;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->line('You have been registered with punchcard!')
            ->line('You are receiving this email because you have been registered with Punchcard but still need to set up your password.')
            ->action('Setup Password', $this->confirmationUrl($this->token,$this->user))

            ->line('You will not be able to access your Punchcard account until you set up your password.')
            ->line('This email will expire in 14 days.');
         
    }

    protected function confirmationUrl($token,$user) {
        return env('APP_SCHEME') . '://' .
               $this->user->client->subdomain .  '.' .
               env('WILDCARD_DOMAIN') . '/password/reset/' .
               $this->token.'?email='.$this->user->email;
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}
