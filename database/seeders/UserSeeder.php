<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        User::create([
            'username' => 'admin',
            'email' => 'admin@example.com',
            'password' => Hash::make('admin123'),
            'role' => 'admin',
        ]);
        User::create([
            'username' => 'user1',
            'email' => 'user1@example.com',
            'password' => Hash::make('user123'),
            'role' => 'user',
        ]);
    }
} 