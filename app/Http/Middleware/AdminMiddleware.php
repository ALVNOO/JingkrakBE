<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AdminMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        // Pastikan user sudah login dan role-nya admin
        if (auth()->check() && auth()->user()->role === 'admin') {
            return $next($request);
        }
        return response()->json(['message' => 'Unauthorized'], 403);
    }
} 