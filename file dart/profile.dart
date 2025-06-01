import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';
  String? _profileImagePath;
  int _totalOrders = 0;
  int _favoriteCount = 0;  // Variabel untuk jumlah favorit

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // Memuat data user dan jumlah favorit dari SharedPreferences
  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'Epengo';
      _profileImagePath = prefs.getString('profile_image');
      _totalOrders = prefs.getInt('total_orders') ?? 0;
      _favoriteCount = prefs.getInt('favorite_count') ?? 0;  // Memuat jumlah favorit
    });
  }

  // Fungsi untuk memilih gambar profil dari galeri
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', image.path);
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Fungsi settings jika diperlukan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian Header Profile
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImagePath != null
                          ? FileImage(File(_profileImagePath!))
                          : const AssetImage('assets/Epengo.jpg') as ImageProvider,
                      backgroundColor: Colors.grey,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatItem(_totalOrders.toString(), 'Orders'),
                      _buildStatItem(_favoriteCount.toString(), 'Favorites'),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    Icons.person_outline,
                    'Personal Information',
                    Icons.chevron_right,
                  ),
                  _buildMenuItem(
                    context,
                    Icons.shopping_bag_outlined,
                    'My Orders',
                    Icons.chevron_right,
                  ),
                  _buildMenuItem(
                    context,
                    Icons.favorite_border,
                    'Favorite Cars',
                    Icons.chevron_right,
                  ),
                  _buildMenuItem(
                    context,
                    Icons.logout,
                    'Log Out',
                    null,
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan statistik (Orders, Favorites)
  static Widget _buildStatItem(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat menu item
  Widget _buildMenuItem(
      BuildContext context,
      IconData leadingIcon,
      String title,
      IconData? trailingIcon, {
        bool isLogout = false,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: isLogout ? Colors.red : Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red : Colors.white,
            fontSize: 16,
          ),
        ),
        trailing: trailingIcon != null
            ? Icon(
          trailingIcon,
          color: Colors.grey,
        )
            : null,
        onTap: () async {
          if (isLogout) {
            _showLogoutDialog(context);
          } else {
            if (title == 'Personal Information') {
              final result = await Navigator.pushNamed(context, '/personal-information');
              if (result == true) {
                _loadUserInfo();
              }
            } else if (title == 'My Orders') {
              Navigator.pushNamed(context, '/my-orders');
            } else if (title == 'Favorite Cars') {
              Navigator.pushNamed(context, '/favorite-cars');
            }
          }
        },
      ),
    );
  }

  // Dialog untuk log out
  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Log Out',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
