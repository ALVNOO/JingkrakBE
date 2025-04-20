import 'package:flutter/material.dart';
import 'login.dart';
import 'Registrasi.dart';
import 'homepage.dart';
import 'catalog.dart';
import 'details.dart';
import 'Order.dart';
import 'test_drive.dart';
import 'order_confirmation.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ferrari App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/catalog': (context) => const CatalogPage(),
        '/payment': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return PaymentScreen(
            carModel: args['model'],
            carPrice: args['price'],
          );
        },
        '/test-drive': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return TestDriveScreen(
            carModel: args['model'],
          );
        },
        '/order-confirmation': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return OrderConfirmationScreen(
            carModel: args['model'],
            carPrice: args['price'],
          );
        },
        '/profile': (context) => const ProfileScreen()
      },
    );
  }
}
