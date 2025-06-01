<?php

namespace App\Http\Controllers;

use App\Models\TestDriveBooking;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TestDriveController extends Controller
{
    // Daftar dealer yang valid
    private $validDealerships = [
        'Dealer Bojongsoang',
        'Dealer Martadinata',
        'Dealer Margacinta',
    ];

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'car_model' => 'required|string',
            'full_name' => 'required|string|max:255',
            'email' => 'required|email',
            'phone' => 'required|string|max:20',
            'preferred_date' => 'required|date|after:today',
            'preferred_time_slot' => 'required|string',
            'dealership' => ['required', 'string', function($attribute, $value, $fail) {
                if (!in_array($value, $this->validDealerships)) {
                    $fail('Dealer yang dipilih tidak valid.');
                }
            }],
        ], [
            'car_model.required' => 'Silakan pilih mobil yang ingin Anda test drive',
            'full_name.required' => 'Nama lengkap wajib diisi',
            'email.required' => 'Email wajib diisi',
            'email.email' => 'Format email tidak valid',
            'phone.required' => 'Nomor telepon wajib diisi',
            'preferred_date.required' => 'Tanggal test drive wajib diisi',
            'preferred_date.after' => 'Tanggal test drive harus setelah hari ini',
            'preferred_time_slot.required' => 'Waktu test drive wajib dipilih',
            'dealership.required' => 'Dealer terdekat wajib dipilih',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Menyesuaikan nama field sebelum disimpan ke database
            $bookingData = [
                'car_model' => $request->car_model,
                'full_name' => $request->full_name,
                'email' => $request->email,
                'phone_number' => $request->phone,
                'preferred_date' => $request->preferred_date,
                'preferred_time_slot' => $request->preferred_time_slot,
                'nearest_dealership' => $request->dealership,
                'status' => 'pending'
            ];

            $booking = TestDriveBooking::create($bookingData);

            return response()->json([
                'message' => 'Test drive booking created successfully',
                'data' => $booking
            ], 201);
        } catch (\Exception $e) {
            \Log::error('Test Drive Booking Error: ' . $e->getMessage());
            return response()->json([
                'message' => 'Failed to create test drive booking',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function index()
    {
        try {
            $bookings = TestDriveBooking::all();
            return response()->json([
                'message' => 'Success',
                'data' => $bookings
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to fetch bookings',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $booking = TestDriveBooking::find($id);
            
            if (!$booking) {
                return response()->json([
                    'message' => 'Booking not found'
                ], 404);
            }

            return response()->json([
                'message' => 'Success',
                'data' => $booking
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to fetch booking',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $booking = TestDriveBooking::find($id);
            
            if (!$booking) {
                return response()->json([
                    'message' => 'Booking not found'
                ], 404);
            }

            $validator = Validator::make($request->all(), [
                'preferred_date' => 'sometimes|date|after:today',
                'preferred_time_slot' => 'sometimes|string',
                'dealership' => ['sometimes', 'string', function($attribute, $value, $fail) {
                    if (!in_array($value, $this->validDealerships)) {
                        $fail('Dealer yang dipilih tidak valid.');
                    }
                }],
                'status' => 'sometimes|in:pending,confirmed,completed,cancelled,rescheduled',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $booking->update($request->all());

            return response()->json([
                'message' => 'Test drive booking updated successfully',
                'data' => $booking
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update test drive booking',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Endpoint untuk mendapatkan daftar dealer yang tersedia
    public function getDealerships()
    {
        return response()->json([
            'message' => 'Success',
            'data' => $this->validDealerships
        ]);
    }
} 