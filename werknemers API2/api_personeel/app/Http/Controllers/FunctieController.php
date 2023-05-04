<?php

namespace App\Http\Controllers;

use App\Models\Functie;
use Illuminate\Http\Request;

class FunctieController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $response = [
            'success' => true,
            'data'    => Functie::All(),
            // 'data'    => Functie::with('werknemers')->get(),
        ];
        return response()->json($response, 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(Functie $functie)
    {
        $response = [
            'success' => true,
            'data'    =>  $functie,
        ];
        return response()->json($response, 200);
    }
}
