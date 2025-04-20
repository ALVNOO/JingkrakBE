import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              // Settings functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Epengo.jpg'),
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Epengo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Ferrari Enthusiast since 2018',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatItem('12', 'Test Drives'),
                      _buildStatItem('3', 'Orders'),
                      _buildStatItem('8', 'Favorites'),
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
                    Icons.history,
                    'Test Drive History',
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
                    Icons.notifications_none,
                    'Notifications',
                    Icons.chevron_right,
                  ),
                  _buildMenuItem(
                    context,
                    Icons.help_outline,
                    'Help Center',
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

  Widget _buildStatItem(String value, String label) {
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
        onTap: () {
          // Handle menu item tap
          if (isLogout) {
            _showLogoutDialog(context);
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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