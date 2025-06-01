import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  List<Map<String, String>> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedOrders = prefs.getStringList('orders') ?? [];

    setState(() {
      _orders = storedOrders.map((order) {
        final parts = order.split('|');
        return {
          'model': parts[0],
          'status': parts[1],
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _orders.isEmpty
          ? const Center(
        child: Text(
          'No Orders Yet',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListTile(
              leading: const Icon(Icons.directions_car, color: Colors.red),
              title: Text(
                order['model']!,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                order['status']!,
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          );
        },
      ),
    );
  }
}
