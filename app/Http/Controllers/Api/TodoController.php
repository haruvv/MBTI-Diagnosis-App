<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Todo;

class TodoController extends Controller
{
    public function index() {
        $todos = Todo::all();
        return response()->json(['todos' => $todos]);
    }

    public function store(Request $request) {
        $todo = Todo::create($request->only('title'));
        return response()->json(['todo' => $todo]);
    }
}