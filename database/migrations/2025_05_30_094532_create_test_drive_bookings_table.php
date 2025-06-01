<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up(): void
    {
        Schema::create('test_drive_bookings', function (Blueprint $table) {
            $table->id();
            $table->string('car_model');
            $table->string('full_name');
            $table->string('email');
            $table->string('phone_number');
            $table->date('preferred_date');
            $table->string('preferred_time_slot');
            $table->string('nearest_dealership');
            $table->enum('status', [
                'pending',
                'confirmed',
                'completed',
                'cancelled',
                'rescheduled'
            ])->default('pending');
            $table->timestamps();
        });
    }

   
    public function down(): void
    {
        Schema::dropIfExists('test_drive_bookings');
    }
};
