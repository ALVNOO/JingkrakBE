<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Car;

class CarSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Car::insert([
            [
                'name' => 'Ferrari Roma',
                'price' => 'Rp9.800.000.000',
                'image' => 'roma.webp',
                'description' => 'Elegant and sleek Ferrari Roma with a V8 engine.',
            ],
            [
                'name' => 'Ferrari SF90 Stradale',
                'price' => 'Rp12.500.000.000',
                'image' => 'sf90.webp',
                'description' => 'High-performance hybrid Ferrari with striking design.',
            ],
            [
                'name' => 'Ferrari 488',
                'price' => 'Rp11.200.000.000',
                'image' => 'ferrari488.webp',
                'description' => 'Twin-turbocharged V8 that delivers exceptional power.',
            ],
            [
                'name' => 'Ferrari Portofino',
                'price' => 'Rp8.500.000.000',
                'image' => 'portofino.webp',
                'description' => 'A grand touring sports car perfect for everyday drive.',
            ],
            [
                'name' => 'Ferrari F80',
                'price' => 'Rp38.500.000.000',
                'image' => 'ferrariF80.webp',
                'description' => 'Futuristic hypercar concept by Ferrari.',
            ],
        ]);
    }
}
