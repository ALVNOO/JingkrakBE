<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TestDriveBooking extends Model
{
    use HasFactory;

    protected $fillable = [
        'car_model',
        'full_name',
        'email',
        'phone_number',
        'preferred_date',
        'preferred_time_slot',
        'nearest_dealership',
        'status'
    ];

    protected $casts = [
        'preferred_date' => 'date',
    ];

    // Relasi dengan Car
    public function car()
    {
        return $this->belongsTo(Car::class);
    }

    // Time slot labels
    public static $timeSlots = [
        'morning' => '09:00 - 12:00',
        'afternoon' => '13:00 - 16:00',
        'evening' => '16:00 - 18:00'
    ];

    // Get formatted time slot
    public function getFormattedTimeSlotAttribute()
    {
        return self::$timeSlots[$this->preferred_time_slot] ?? $this->preferred_time_slot;
    }
} 