<?php

namespace App\Providers;

use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function boot()
    {
        $this->routes(function () {
            // Load routes/web.php untuk route web biasa
            Route::middleware('web')
                ->group(base_path('routes/web.php'));

            // Load routes/api.php untuk route API dengan prefix /api
            Route::prefix('api')
                ->middleware('api')
                ->group(base_path('routes/api.php'));
        });
    }
}
