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
            $imagePath = 'storage/images/' . $car->image;
            $fullUrl = url($imagePath);
            
            \Log::info('Image path: ' . $imagePath);
            \Log::info('Full URL: ' . $fullUrl);
            return [
                'id' => $car->id,
                'name' => $car->name,
                'price' => $car->price,
                'image' => url('storage/images/' . $car->image), // Menggunakan url() helper
                'type' => $car->type,
            ];
        });

        return response()->json($cars);
    }

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
            'image' => url('storage/images/' . $car->image), // Menggunakan url() helper
            'description' => $car->description,
        ]);
    }

    // POST /api/cars (admin only)
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|string',
            'image' => 'required|string', // atau file jika upload
            'description' => 'nullable|string',
            'type' => 'nullable|string',
        ]);

        $car = Car::create($request->all());
        return response()->json(['message' => 'Car added', 'car' => $car], 201);
    }

    // PUT /api/cars/{id} (admin only)
    public function update(Request $request, $id)
    {
        $car = Car::findOrFail($id);
        $car->update($request->all());
        return response()->json(['message' => 'Car updated', 'car' => $car]);
    }

    // DELETE /api/cars/{id} (admin only)
    public function destroy($id)
    {
        $car = Car::findOrFail($id);
        $car->delete();
        return response()->json(['message' => 'Car deleted']);
    }
}
