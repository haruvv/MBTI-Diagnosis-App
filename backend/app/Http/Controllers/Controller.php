<?php

namespace App\Http\Controllers;

abstract class Controller
{
    public function index()
    {
        return response()->json([
            'message' => 'Hello, this is a test change for CI/CD!',
            'timestamp' => now(),
        ]);
    }
}
