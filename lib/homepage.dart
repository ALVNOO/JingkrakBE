import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan logo dan avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logoFerrari.jpg', height: 40),
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Konten utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explore Ferrari',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Models',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Section Top Models
            _buildSectionTitle('Top Models'),
            _buildTopModels(),

            // Section Reviews
            _buildSectionTitle('Reviews'),
            _buildReviewCard(),

            // Section Available dengan tombol See All
            _buildSectionTitle(
              'Available',
              showSeeAll: true,
              onSeeAll: () => Navigator.pushNamed(context, '/catalog'),
            ),
            _buildAvailableCar(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildSectionTitle(String title, {
    bool showSeeAll = false,
    VoidCallback? onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showSeeAll)
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                'See All',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopModels() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildModelCard('Roma', 'assets/Ferrari_Roma.jpg'),
          _buildModelCard('SF90', 'assets/ferarri_sf90.jpg'),
          _buildModelCard('488', 'assets/ferarri_488.jpg'),
          _buildModelCard('Portofino', 'assets/portofino.jpg'),
          _buildModelCard('F80', 'assets/f80.jpg'),
        ],
      ),
    );
  }

  Widget _buildModelCard(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 70,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
              name,
              style: const TextStyle(color: Colors.white)
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                  'assets/reviewf90.jpg',
                  width: 100,
                  fit: BoxFit.cover
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Top Ferrari Review',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableCar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
            'assets/f80.jpg',
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.white,
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) {
          Navigator.pushNamed(context, '/catalog');
        }
        if (index == 1) {
          Navigator.pushNamed(context, '/catalog');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/profile');
        }
      },

      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Catalog'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
        ),
      ],
    );
  }
}