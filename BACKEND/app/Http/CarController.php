<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Car;

class CarController extends Controller
{
    // Menampilkan semua mobil (top models, available, dll)
    public function index()
    {
        $cars = Car::all()->map(function ($car) {
            return [
                'id' => $car->id,
                'name' => $car->name,
                'price' => $car->price,
                'image' => asset('storage/images/' . $car->image), // URL gambar
                'type' => $car->type, // optional: top, available, review
            ];
        });

        return response()->json($cars);
    }

    // Menampilkan detail mobil (jika ingin diakses per ID)
    public function show($id)
    {
        $car = Car::find($id);

        if (!$car) {
            return response()->json(['message' => 'Car not found'], 404);
        }

        return response()->json([
            'id' => $car->id,
            'name' => $car->name,
            'price' => $car->price,
            'image' => asset('storage/images/' . $car->image),
            'description' => $car->description,
        ]);
    }
}
