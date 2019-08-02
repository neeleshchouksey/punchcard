<?php namespace App\ValidationTraits;

trait ProfileTrait
{
    protected function defineRules()
    {
        return [
            'title' => 'required|unique:posts|max:255',
            'body' => 'required',
        ];
    }
}
