<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return 'Hello, World! (root directory!!!!!!!!)';
});

Route::get('/test', function () {
    return 'Hello, World!!';
});
