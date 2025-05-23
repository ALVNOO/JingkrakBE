import 'package:flutter/material.dart';
import 'details.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<Map<String, String>> cars = [
    {
      'model': 'Ferrari SF90 Stradale',
      'price': 'Rp12.500.000.000',
      'image': 'assets/sf90.jpg',
    },
    {
      'model': 'Ferrari Roma',
      'price': 'Rp9.800.000.000',
      'image': 'assets/Ferrari_Roma.jpg',
    },
    {
      'model': 'Ferrari 488 GTB',
      'price': 'Rp11.200.000.000',
      'image': 'assets/ferarri_488.jpg',
    },
    {
      'model': 'Ferrari Portofino M',
      'price': 'Rp8.500.000.000',
      'image': 'assets/portofino.jpg',
    },
    {
      'model': 'Ferrari F8',
      'price': 'Rp38.500.000.000',
      'image': 'assets/f80.jpg',
    },
  ];

  List<Map<String, String>> filteredCars = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCars = cars; // Awalnya tampil semua mobil
  }

  voi_filterCars(String query) {
    final result = cars.where((car) {
      final modelLower = car['model']!.toLowerCase();
      final searchLower = query.toLowerCase();
      return modelLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredCars = result;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Ferrari Catalog',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: _filterCars,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: 'Search Models...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Car List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredCars.length,
              itemBuilder: (context, index) {
                final car = filteredCars[index];
                return _buildCarCard(
                  context,
                  car['model']!,
                  car['price']!,
                  car['image']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarCard(BuildContext context, String modelName, String price, String imagePath) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.2),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modelName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Current Price',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarDetailPage(
                            carModel: modelName,
                            carPrice: price,
                            carImage: imagePath,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('View More'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
