import 'package:flutter/material.dart';

class AddCarPage extends StatefulWidget {
  final Map<String, dynamic>? existingCar; // kalau edit, bawa datanya

  const AddCarPage({super.key, this.existingCar});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _modelController;
  late TextEditingController _priceController;
  String? _selectedImage;

  final List<String> availableImages = [
    'assets/ferarri_sf90.jpg',
    'assets/Ferrari_Roma.jpg',
    'assets/ferarri_488.jpg',
    'assets/portofino.jpg',
    'assets/f80.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(text: widget.existingCar?['model'] ?? '');
    _priceController = TextEditingController(text: widget.existingCar?['price'] ?? '');
    _selectedImage = widget.existingCar?['image']; // kalau edit, ambil gambar yang lama
  }

  @override
  void dispose() {
    _modelController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveCar() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a car image')),
        );
        return;
      }

      final carData = {
        'model': _modelController.text.trim(),
        'price': _priceController.text.trim(),
        'image': _selectedImage,
      };

      Navigator.pop(context, carData); // kirim balik ke halaman sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingCar != null;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(isEditing ? 'Edit Car' : 'Add New Car', style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _modelController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Car Model',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Model name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Price is required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedImage,
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Car Image',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: availableImages.map((imgPath) {
                  return DropdownMenuItem(
                    value: imgPath,
                    child: Text(
                      imgPath.split('/').last,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedImage = value;
                  });
                },
                validator: (value) => value == null ? 'Please select an image' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveCar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(isEditing ? 'Save Changes' : 'Add Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
