<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Champion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ChampionsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Champion::with('hobbies')->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'naam' => 'required',
            'klas' => 'required'
        ]);
        if ($validator->fails()) {
            return response('{"Foutmelding":"Data niet correct"}', 400)->header('Content-Type', 'application/json');
        }
        $champion = Champion::create($request->only(['naam', 'klas']));
        return $champion;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Champion  $champion
     * @return \Illuminate\Http\Response
     */
    public function show(Champion $champion)
    {
        return $champion->load('hobbies');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Champion  $champion
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Champion $champion)
    {
        $validator = Validator::make($request->all(), [
            'naam' => 'required',
            'klas' => 'required'
        ]);
        if ($validator->fails()) {
            return response('{"Foutmelding":"Data niet correct"}', 400)->header('Content-Type', 'application/json');
        }

        $champion->update($request->only(['naam', 'klas']));
        return $champion;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Champion  $champion
     * @return \Illuminate\Http\Response
     */
    public function destroy(Champion $champion)
    {
        $champion->delete();
    }
}

