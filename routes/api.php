<?php

use Illuminate\Routing\Route;
use Illuminate\Http\Request;

// JSONレスポンスを返すルート
Route::get('/api/data', function () {
    return response()->json(['message' => 'Hello, API!!!!!!!']);
});

Route::get('/user', function (Request $request) {
    return response()->json(['name' => 'John Doe']);
});