<?php

namespace App\Http\Controllers;

abstract class Controller
{
    public function show()
    {
        return response()->json(['data' => $someData]);
    }
}
