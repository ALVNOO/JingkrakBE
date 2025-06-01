<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Car extends Model
{
    use HasFactory;

    // Nama tabel (jika tidak mengikuti konvensi)
    protected $table = 'cars';

    // Field yang boleh diisi secara massal
    protected $fillable = [
        'name',
        'price',
        'image',
        'description',
        'type',
    ];
}
