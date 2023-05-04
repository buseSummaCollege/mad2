<?php

use App\Http\Controllers\Api\ChampionHobbyController;
use App\Http\Controllers\Api\ChampionsController;
use App\Http\Controllers\Api\HobbiesController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('champions/{champion}/hobbies/{hobby}', [ChampionHobbyController::class, 'store']);
Route::delete('champions/{champion}/hobbies/{hobby}', [ChampionHobbyController::class, 'destroy']);

Route::apiResource('champions', ChampionsController::class);
Route::apiResource('hobbies', HobbiesController::class);

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
