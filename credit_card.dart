import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_confirmation.dart';

class CreditCardPaymentScreen extends StatefulWidget {
  final String carModel;
  final String carPrice;

  const CreditCardPaymentScreen({
    super.key,
    required this.carModel,
    required this.carPrice,
  });

  @override
  State<CreditCardPaymentScreen> createState() => _CreditCardPaymentScreenState();
}

class _CreditCardPaymentScreenState extends State<CreditCardPaymentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _payNow() async {
    // Validasi: semua field harus diisi
    if (_nameController.text.isEmpty ||
        _numberController.text.isEmpty ||
        _expiryController.text.isEmpty ||
        _cvvController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    // Tambah mobil ke list orders
    final List<String> existingOrders = prefs.getStringList('orders') ?? [];
    final newOrder = '${widget.carModel}|Processing';
    existingOrders.add(newOrder);
    await prefs.setStringList('orders', existingOrders);

    // Tambah angka total orders
    int totalOrders = prefs.getInt('total_orders') ?? 0;
    totalOrders++;
    await prefs.setInt('total_orders', totalOrders);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderConfirmationScreen(
          carModel: widget.carModel,
          carPrice: widget.carPrice,
        ),
      ),
    );
  }

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
          'Credit Card Payment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField('Card Holder Name', _nameController),
            const SizedBox(height: 15),
            _buildTextField('Card Number', _numberController, inputType: TextInputType.number),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildTextField('MM/YY', _expiryController)),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField('CVV', _cvvController, inputType: TextInputType.number)),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _payNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'PAY NOW',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {TextInputType? inputType}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: inputType,
    );
  }
}
