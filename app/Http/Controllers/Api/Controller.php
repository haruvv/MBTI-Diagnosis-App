<?php

namespace App\Http\Controllers\Api;

abstract class Controller
{
    public function show()
    {
        // return response()->json(['data' => $someData]);
        return response()->json(['data' => 'dddd']);
    }
}
