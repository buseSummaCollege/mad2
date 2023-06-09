<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\FunctieController;
use App\Http\Controllers\WerknemerController;
use App\Http\Controllers\AuthenticationController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('/register', [AuthenticationController::class, 'register']);
Route::post('/login', [AuthenticationController::class, 'login']);

Route::apiResource('functies', FunctieController::class)
               ->parameters(['functies' => 'functie'])
               ->only(['index', 'show']);

Route::apiResource('werknemers', WerknemerController::class);
Route::get('functies/{id}/werknemers', [WerknemerController::class, 'indexFunctie']);
Route::delete('functies/{id}/werknemers', [WerknemerController::class, 'destroyFunctie']);

Route::apiResource('functies', FunctieController::class)->parameters(['functies' => 'functie'])
                ->only(['index', 'show']);

Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::get('profile', function (Request $request) { 
        return auth()->user(); 
    });

    Route::apiResource('werknemers', WerknemerController::class);
    Route::get('functies/{id}/werknemers', [WerknemerController::class, 'indexFunctie']);
    Route::delete('functies/{id}/werknemers', [WerknemerController::class, 'destroyFunctie']);

    Route::post('/logout', [AuthenticationController::class, 'logout']);
});

Route::fallback(function () {
    return response()->json([
        'message' => 'Page Not Found. If error persists, contact info@website.com '], 404);
});
