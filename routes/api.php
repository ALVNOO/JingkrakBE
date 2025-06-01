<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CarController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\TestDriveController;
use App\Http\Controllers\LikedCarController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/admin/login', [AuthController::class, 'loginAdmin']);
Route::middleware(['auth:sanctum', 'admin'])->post('/admin/register', [AuthController::class, 'registerAdmin']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user/profile', [UserController::class, 'profile']);
    Route::put('/user/profile', [UserController::class, 'updateProfile']);
    
    // Liked Cars routes
    Route::post('/cars/like', [LikedCarController::class, 'toggleLike']);
    Route::get('/cars/liked', [LikedCarController::class, 'getLikedCars']);
    Route::get('/cars/{carModel}/like-status', [LikedCarController::class, 'checkLikeStatus']);
});

Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);

// Car routes
Route::get('/cars', [CarController::class, 'index']);
Route::get('/cars/{id}', [CarController::class, 'show']);

Route::post('/payment', [PaymentController::class, 'store']);

Route::get('/users', function() {
    return response()->json(['users' => \App\Models\User::all()]);
});

Route::get('/create-test-user', function() {
    $user = \App\Models\User::create([
        'username' => 'testuser',
        'email' => 'test@example.com',
        'password' => bcrypt('password123')
    ]);
    return response()->json([
        'message' => 'Test user created',
        'user' => $user
    ]);
});

// Test Drive Routes
Route::post('/test-drive', [TestDriveController::class, 'store']);
Route::get('/test-drive', [TestDriveController::class, 'index']);
Route::get('/test-drive/{id}', [TestDriveController::class, 'show']);
Route::put('/test-drive/{id}', [TestDriveController::class, 'update']);
Route::get('/dealerships', [TestDriveController::class, 'getDealerships']);

// Untuk admin (POST, PUT, DELETE)
Route::middleware(['auth:sanctum', 'admin'])->group(function () {
    Route::post('/cars', [CarController::class, 'store']);
    Route::put('/cars/{id}', [CarController::class, 'update']);
    Route::delete('/cars/{id}', [CarController::class, 'destroy']);
});

