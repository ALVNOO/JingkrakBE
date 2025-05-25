import 'package:flutter/material.dart';
import 'admin_add_car.dart';
import 'admin_edit_car.dart';

class AdminCatalogPage extends StatefulWidget {
  const AdminCatalogPage({super.key});

  @override
  State<AdminCatalogPage> createState() => _AdminCatalogPageState();
}

class _AdminCatalogPageState extends State<AdminCatalogPage> {
  List<Map<String, dynamic>> carList = [
    {
      'model': 'Ferrari SF90 Stradale',
      'price': 'Rp12.500.000.000',
      'image': 'assets/sf90.jpg',
      'stock': 5,
    },
    {
      'model': 'Ferrari Roma',
      'price': 'Rp9.800.000.000',
      'image': 'assets/Ferrari_Roma.jpg',
      'stock': 7,
    },
    {
      'model': 'Ferrari Portofino M',
      'price': 'Rp8.500.000.000',
      'image': 'assets/portofino.jpg',
      'stock': 4,
    },
    {
      'model': 'Ferrari F8',
      'price': 'Rp38.500.000.000',
      'image': 'assets/f80.jpg',
      'stock': 2,
    },
  ];

  List<Map<String, dynamic>> filteredCarList = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCarList = List.from(carList);
  }

  void _filterCars(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      filteredCarList = carList
          .where((car) => car['model'].toLowerCase().contains(lowerQuery))
          .toList();
    });
  }

  Future<void> _navigateToAddCar() async {
    final newCar = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCarPage()),
    );

    if (newCar != null) {
      setState(() {
        carList.add(newCar);
        filteredCarList = List.from(carList);
      });
    }
  }

  Future<void> _navigateToEditCar(int index) async {
    final editedCar = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminEditCarPage(
          car: filteredCarList[index],
        ),
      ),
    );

    if (editedCar != null) {
      final originalIndex = carList.indexOf(filteredCarList[index]);
      setState(() {
        carList[originalIndex] = editedCar;
        filteredCarList = List.from(carList);
      });
    }
  }

  void _confirmDeleteCar(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Konfirmasi Hapus',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Yakin mau hapus mobil ini?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              child: const Text('Batal', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () {
                final originalIndex = carList.indexOf(filteredCarList[index]);
                setState(() {
                  carList.removeAt(originalIndex);
                  filteredCarList = List.from(carList);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mobil berhasil dihapus!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _increaseStock(int index) {
    final originalIndex = carList.indexOf(filteredCarList[index]);
    setState(() {
      carList[originalIndex]['stock']++;
      filteredCarList = List.from(carList);
    });
  }

  void _decreaseStock(int index) {
    final originalIndex = carList.indexOf(filteredCarList[index]);
    setState(() {
      if (carList[originalIndex]['stock'] > 0) {
        carList[originalIndex]['stock']--;
      }
      filteredCarList = List.from(carList);
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
        title: const Text('Admin Catalog', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _navigateToAddCar,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: _filterCars,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Cari Model...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredCarList.length,
              itemBuilder: (context, index) {
                final car = filteredCarList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey[800]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          car['image'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car['model'],
                              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              car['price'],
                              style: const TextStyle(fontSize: 18, color: Colors.white70),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, color: Colors.redAccent),
                                    onPressed: () => _decreaseStock(index),
                                  ),
                                  Text(
                                    '${car['stock']}',
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, color: Colors.greenAccent),
                                    onPressed: () => _increaseStock(index),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _navigateToEditCar(index);
                                    } else if (value == 'delete') {
                                      _confirmDeleteCar(index);
                                    }
                                  },
                                  icon: const Icon(Icons.more_vert, color: Colors.white),
                                  color: Colors.grey[900],
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit', style: TextStyle(color: Colors.white)),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
