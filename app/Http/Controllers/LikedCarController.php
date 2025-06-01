<?php

namespace App\Http\Controllers;

use App\Models\LikedCar;
use App\Models\Car;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LikedCarController extends Controller
{
    public function toggleLike(Request $request)
    {
        try {
            $car = Car::where('name', $request->car_model)->first();
            
            if (!$car) {
                return response()->json([
                    'message' => 'Car not found'
                ], 404);
            }

            $existingLike = LikedCar::where('user_id', Auth::id())
                ->where('car_id', $car->id)
                ->first();

            if ($existingLike) {
                $existingLike->delete();
                return response()->json([
                    'message' => 'Car unliked successfully',
                    'is_liked' => false
                ]);
            }

            LikedCar::create([
                'user_id' => Auth::id(),
                'car_id' => $car->id
            ]);

            return response()->json([
                'message' => 'Car liked successfully',
                'is_liked' => true
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error toggling like status',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getLikedCars()
    {
        try {
            $likedCars = LikedCar::where('user_id', Auth::id())
                ->with('car')
                ->get()
                ->map(function ($likedCar) {
                    return [
                        'id' => $likedCar->car->id,
                        'name' => $likedCar->car->name,
                        'price' => $likedCar->car->price,
                        'image' => url('storage/images/' . $likedCar->car->image)
                    ];
                });

            return response()->json($likedCars);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error fetching liked cars',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function checkLikeStatus($carModel)
    {
        try {
            $car = Car::where('name', $carModel)->first();
            
            if (!$car) {
                return response()->json([
                    'message' => 'Car not found'
                ], 404);
            }

            $isLiked = LikedCar::where('user_id', Auth::id())
                ->where('car_id', $car->id)
                ->exists();

            return response()->json([
                'is_liked' => $isLiked
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error checking like status',
                'error' => $e->getMessage()
            ], 500);
        }
    }
} 