<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return 'Hello, World! (root directory!!!!)';
});

Route::get('/test', function () {
    return 'Hello, World!!!!!';
});

Route::get('/env-test', function () {
    return response()->json([
        'APP_NAME' => env('APP_NAME'),
        'APP_KEY' => env('APP_ENV'),
        'APP_ENV' => env('APP_ENV'),
        'DB_HOST' => env('DB_HOST'),
        'DB_DATABASE' => env('DB_DATABASE'),
    ]);
});

