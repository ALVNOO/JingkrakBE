<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Seed users
        User::factory()->create([
            'username' => 'Test User',
            'password' => bcrypt('password123'),
        ]);

        // Seed cars
        $this->call(\Database\Seeders\CarSeeder::class);
    }
}
