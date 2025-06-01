import 'package:flutter/material.dart';
import 'order_confirmation.dart';
import 'credit_card.dart';
import 'bank_transfer.dart';

class PaymentScreen extends StatelessWidget {
  final String carModel;
  final String carPrice;

  const PaymentScreen({
    super.key,
    required this.carModel,
    required this.carPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment Method',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Info
            Text(
              carModel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              carPrice,
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),

            // Payment Options
            const Text(
              'Select Payment Method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Credit Card
            _buildPaymentOption(
              context,
              Icons.credit_card,
              'Credit Card',
              Colors.blue,
            ),

            // Bank Transfer
            _buildPaymentOption(
              context,
              Icons.account_balance,
              'Bank Transfer',
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.grey[900],
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: () {
          if (title == 'Credit Card') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreditCardPaymentScreen(
                  carModel: carModel,
                  carPrice: carPrice,
                ),
              ),
            );
          } else if (title == 'Bank Transfer') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BankTransferPaymentScreen(
                  carModel: carModel,
                  carPrice: carPrice,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
