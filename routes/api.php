<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::apiResource('todos', \App\Http\Controllers\Api\TodoController::class);