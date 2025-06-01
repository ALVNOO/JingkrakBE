<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CreditCardPayment;
use Illuminate\Support\Facades\Validator;

class PaymentController extends Controller
{
    /**
     * Simpan data pembayaran dan order baru
     */
    public function store(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|integer|exists:users,id',
            'card_holder_name' => 'required|string|max:255',
            'card_number' => 'required|string|size:16',
            'expiry_date' => 'required|string|size:5', // Format: MM/YY
            'cvv' => 'required|string|size:3',
        ], [
            'user_id.exists' => 'User ID tidak ditemukan dalam database.',
            'card_number.size' => 'Nomor kartu harus 16 digit.',
            'expiry_date.size' => 'Format tanggal kadaluarsa harus MM/YY (contoh: 12/25)',
            'cvv.size' => 'CVV harus 3 digit.'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Validasi format expiry_date manual
        $expiry = $request->expiry_date;
        if (!preg_match('/^(0[1-9]|1[0-2])\/(2[3-9]|[3-9][0-9])$/', $expiry)) {
            return response()->json([
                'message' => 'Validation error',
                'errors' => [
                    'expiry_date' => ['Format tanggal kadaluarsa harus MM/YY dan tahun harus >= 23']
                ]
            ], 422);
        }

        try {
            // Simpan data pembayaran
            $payment = CreditCardPayment::create([
                'user_id' => $request->user_id,
                'card_holder_name' => $request->card_holder_name,
                'card_number' => $request->card_number,
                'expiry_date' => $request->expiry_date,
                'CVV' => $request->cvv,
                'status' => 'processing'
            ]);

            // Di sini Anda bisa menambahkan logika untuk memproses pembayaran
            // Misalnya integrasi dengan payment gateway

            // Update status pembayaran menjadi success
            $payment->update(['status' => 'success']);

            return response()->json([
                'message' => 'Payment processed successfully',
                'data' => [
                    'payment_id' => $payment->id,
                    'status' => $payment->status
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Payment processing failed',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
