import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'details.dart'; // pastikan import path sesuai

class FavoriteCarsScreen extends StatefulWidget {
  const FavoriteCarsScreen({super.key});

  @override
  _FavoriteCarsScreenState createState() => _FavoriteCarsScreenState();
}

class _FavoriteCarsScreenState extends State<FavoriteCarsScreen> {
  List<Map<String, String>> favoriteCars = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteCars();
  }

  // Memuat daftar mobil favorit
  Future<void> _loadFavoriteCars() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_cars') ?? [];

    // Daftar mobil yang tersedia
    final allCars = [
      {
        'model': 'Ferrari Portofino',
        'price': 'Rp8.500.000.000',
        'image': 'assets/portofino.jpg'
      },
      {
        'model': 'Ferrari F80',
        'price': 'Rp38.500.000.000',
        'image': 'assets/f80.jpg'
      },
      {
        'model': 'Ferrari Roma',
        'price': 'Rp9.800.000.000',
        'image': 'assets/Ferrari_Roma.jpg'
      },
      {
        'model': 'Ferrari SF90 Stradale',
        'price': 'Rp12.500.000.000',
        'image': 'assets/sf90.jpg'
      },
    ];

    // Menyaring mobil-mobil yang ada di favorit
    setState(() {
      favoriteCars = allCars
          .where((car) => favorites.contains(car['model']))
          .toList();
    });
  }

  // Menambahkan mobil ke favorit
  Future<void> _addFavorite(String carModel) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_cars') ?? [];

    if (!favorites.contains(carModel)) {
      favorites.add(carModel);
      await prefs.setStringList('favorite_cars', favorites);

      // Update jumlah favorit di SharedPreferences
      await prefs.setInt('favorite_count', favorites.length);

      // Memuat ulang daftar favorit
      _loadFavoriteCars();
    }
  }

  // Menghapus mobil dari favorit
  Future<void> _removeFavorite(String carModel) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_cars') ?? [];

    favorites.remove(carModel);
    await prefs.setStringList('favorite_cars', favorites);

    // Update jumlah favorit di SharedPreferences
    await prefs.setInt('favorite_count', favorites.length);

    // Memuat ulang daftar favorit
    _loadFavoriteCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Favorite Cars',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: favoriteCars.isEmpty
            ? const Center(
          child: Text(
            'No favorite cars yet.',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
            : GridView.builder(
          itemCount: favoriteCars.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final car = favoriteCars[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarDetailPage(
                      carModel: car['model']!,
                      carPrice: car['price']!,
                      carImage: car['image']!,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.asset(
                          car['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      car['model']!,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
