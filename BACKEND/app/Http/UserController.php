<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;

class UserController extends Controller
{
    // GET /api/user/profile
    public function profile(Request $request)
    {
        // Kembalikan data user yang sedang login
        return response()->json($request->user());
    }

    // PUT /api/user/profile
    public function updateProfile(Request $request)
    {
        $user = $request->user();

        // Validasi input data, username dan email unik kecuali untuk user ini
        $request->validate([
            'username' => 'sometimes|string|max:255|unique:users,username,' . $user->id,
            'email' => 'sometimes|email|unique:users,email,' . $user->id,
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        // Jika ada file profile_picture yang diupload
        if ($request->hasFile('profile_picture')) {
            // Hapus gambar lama jika bukan default dan file ada
            if ($user->profile_picture !== 'default.png') {
                $oldPath = storage_path('app/public/images/' . $user->profile_picture);
                if (File::exists($oldPath)) {
                    File::delete($oldPath);
                }
            }

            // Simpan gambar baru
            $filename = time() . '.' . $request->profile_picture->extension();
            $request->profile_picture->storeAs('public/images', $filename);

            // Update nama file di database
            $user->profile_picture = $filename;
        }

        // Update username dan email jika ada
        if ($request->has('username')) {
            $user->username = $request->username;
        }

        if ($request->has('email')) {
            $user->email = $request->email;
        }

        // Simpan perubahan user
        $user->save();

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $user,
        ]);
    }
}
