<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CreditCardPayment extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'card_holder_name',
        'card_number',
        'expiry_date',
        'CVV',
        'status'
    ];

    // Relasi dengan User
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Mutator untuk mengenkripsi nomor kartu sebelum disimpan
    public function setCardNumberAttribute($value)
    {
        $this->attributes['card_number'] = encrypt($value);
    }

    // Accessor untuk mendekripsi nomor kartu saat diambil
    public function getCardNumberAttribute($value)
    {
        return decrypt($value);
    }

    // Mutator untuk mengenkripsi CVV sebelum disimpan
    public function setCVVAttribute($value)
    {
        $this->attributes['CVV'] = encrypt($value);
    }

    // Accessor untuk mendekripsi CVV saat diambil
    public function getCVVAttribute($value)
    {
        return decrypt($value);
    }
} 