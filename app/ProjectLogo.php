<?php namespace App;

use Storage;
use Intervention\Image\Facades\Image;

class ProjectLogo
{
    protected $uniq_id;
    protected $storage;

    public function __construct($uniq_id)
    {
        $this->uniq_id = $uniq_id;
        $this->storage = Storage::disk('project-logos');
    }

    public function handle()
    {
        if (! $this->uniq_id) {
            return false;
        }

        foreach (['png', 'jpg'] as $ext) {
            $fileName = $this->uniq_id . '.' . $ext;
            if ($this->storage->exists($fileName)) {
                return Image::make($this->storage->get($fileName))
                    ->response();
                //     ->withHeaders([
                //     'Cache-Control' => 'public'
                // ]);
            }
        }

        return $this->placeholderLogo();
    }




    private function placeholderLogo()
    {
        $placeholder = 'placeholder-project-logo.png';
        if (! Storage::disk('local')->exists($placeholder)) {
            return $this->jsonFailure("Neither user or default logo found");
        }

        // our placeholder apparently is not a valid image
        return Image::make(Storage::disk('local')->get($placeholder))->response();
    }
}
