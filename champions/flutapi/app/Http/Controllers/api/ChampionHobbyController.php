<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Champion;
use App\Models\Hobby;

class ChampionHobbyController extends Controller
{
    /**
     * Store a newly created resource in storage.
     *
     * @param  $champion, $hobby
     * @return nothing: if not already attached, champion and hobby will be attached
     */
    public function store(Champion $champion, Hobby $hobby)
    {
        try {
            $champion->hobbies()->attach($hobby);
        } catch (\Throwable $th) {

        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  $champion, $hobby
     * @return nothing: if not already detached, champion and hobby will be dettached
     */
    public function destroy(Champion $champion, Hobby $hobby)
    {
        try {
            $champion->hobbies()->detach($hobby);;
        } catch (\Throwable $th) {

        }
    }
}

