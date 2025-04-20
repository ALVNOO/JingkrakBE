import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String carModel;
  final String carPrice;

  const OrderConfirmationScreen({
    super.key,
    required this.carModel,
    required this.carPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Title
              const Text(
                'ORDER CONFIRMED!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Car Info
              Text(
                carModel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                carPrice,
                style: TextStyle(
                  color: Colors.red[600],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // Order Details
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildOrderDetailRow('Order ID', '#FERR123456'),
                    const Divider(color: Colors.grey),
                    _buildOrderDetailRow('Date', '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                    const Divider(color: Colors.grey),
                    _buildOrderDetailRow('Payment Method', 'Credit Card'),
                    const Divider(color: Colors.grey),
                    _buildOrderDetailRow('Status', 'Done'),
                  ],
                ),
              ),

              const Spacer(),

              // Back to Home Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                            (route) => false
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'BACK TO HOME',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}