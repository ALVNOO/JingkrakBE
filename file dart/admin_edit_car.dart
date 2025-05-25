import 'package:flutter/material.dart';

class AdminEditCarPage extends StatefulWidget {
  final Map<String, dynamic> car;

  const AdminEditCarPage({super.key, required this.car});

  @override
  State<AdminEditCarPage> createState() => _AdminEditCarPageState();
}

class _AdminEditCarPageState extends State<AdminEditCarPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.car['model']);
    priceController = TextEditingController(text: widget.car['price']);
    imageController = TextEditingController(text: widget.car['image']);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  void _saveCar() {
    final editedCar = {
      'name': nameController.text,
      'price': priceController.text,
      'image': imageController.text,
    };
    Navigator.pop(context, editedCar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Edit Car', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nameController, 'Car Model'),
            const SizedBox(height: 16),
            _buildTextField(priceController, 'Price'),
            const SizedBox(height: 16),
            _buildTextField(imageController, 'Image Path'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveCar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
