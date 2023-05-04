<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hobby;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class HobbiesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Hobby::with('champions')->get();
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
        ]);
        if ($validator->fails()) {
            return response('{"Foutmelding":"Data niet correct"}', 400)->header('Content-Type', 'application/json');
        }
        $hobby = Hobby::create($request->only(['naam']));
        return $hobby;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Hobby  $hobby
     * @return \Illuminate\Http\Response
     */
    public function show(Hobby $hobby)
    {
        return $hobby->load('champions');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Hobby  $hobby
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Hobby $hobby)
    {
        $validator = Validator::make($request->all(), [
            'naam' => 'required',
        ]);
        if ($validator->fails()) {
            return response('{"Foutmelding":"Data niet correct"}', 400)->header('Content-Type', 'application/json');
        }

        $hobby->update($request->only(['naam']));
        return $hobby;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Hobby  $hobby
     * @return \Illuminate\Http\Response
     */
    public function destroy(Hobby $hobby)
    {
        $hobby->delete();
    }
}


