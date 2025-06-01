<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class OptimizeImages
{
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);

        // Jika response adalah file gambar
        if ($this->isImage($request->path())) {
            $response->header('Cache-Control', 'public, max-age=31536000');
            $response->header('Accept-Ranges', 'bytes');
            $response->header('Vary', 'Accept-Encoding');
        }

        return $response;
    }

    private function isImage($path)
    {
        $extensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
        $extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));
        return in_array($extension, $extensions);
    }
} 