<?php

use Illuminate\Routing\Route;

Route::get('/example', function () {
    return response()->json(['message' => 'This is an API endpoint']);
});