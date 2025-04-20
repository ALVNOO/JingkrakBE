import 'package:flutter/material.dart';
import 'Order.dart';
import 'test_drive.dart';
import 'order_confirmation.dart';

class CarDetailPage extends StatelessWidget {
  final String carModel;
  final String carPrice;
  final String carImage;

  const CarDetailPage({
    super.key,
    required this.carModel,
    required this.carPrice,
    required this.carImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    carImage,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carModel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          carPrice,
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Specifications Section
                  const Text(
                    'SPECIFICATIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ..._getCarSpecifications(carModel),
                  const SizedBox(height: 30),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman Book Test Drive
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestDriveScreen(
                                  carModel: carModel,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey[800]!),
                            ),
                          ),
                          child: const Text('BOOK TEST DRIVE'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman Payment
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  carModel: carModel,
                                  carPrice: carPrice,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('ORDER NOW'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Review Section
                  const Text(
                    'Review',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.red,
                          width: 4,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'FITRA ERI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '1000PS',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'FIRST IMPRESSION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    carModel.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/reviewSF90.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getCarSpecifications(String model) {
    final specs = <Map<String, String>>[];

    switch (model) {
      case 'Ferrari SF90 Stradale':
        specs.addAll([
          {'Engine': '4.0L V8 Twin-Turbo + 3 Electric Motors'},
          {'Power': '1000 PS (986 hp)'},
          {'0-100 km/h': '2.5 seconds'},
          {'Top Speed': '340 km/h'},
          {'Electric Range': '25 km'},
        ]);
        break;
      case 'Ferrari Roma':
        specs.addAll([
          {'Engine': '3.9L V8 Twin-Turbo'},
          {'Power': '620 PS (612 hp)'},
          {'0-100 km/h': '3.4 seconds'},
          {'Top Speed': '320 km/h'},
          {'Transmission': '8-Speed Dual-Clutch'},
        ]);
        break;
      default:
        specs.addAll([
          {'Engine': 'V8/V12 Engine'},
          {'Power': '600+ PS'},
          {'0-100 km/h': 'Under 3.5 seconds'},
          {'Top Speed': '320+ km/h'},
        ]);
    }

    return specs.map((spec) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                spec.keys.first,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Text(
                spec.values.first,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}