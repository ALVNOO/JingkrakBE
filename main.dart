import 'package:flutter/material.dart';
import 'login.dart';
import 'registrasi.dart';
import 'homepage.dart';
import 'catalog.dart';
import 'details.dart';
import 'Order.dart';
import 'test_drive.dart';
import 'order_confirmation.dart';
import 'profile.dart';
import 'personal_information.dart';
import 'myorders.dart';
import 'favorite_cars.dart';
import 'admin_home.dart';
import 'catalog_admin.dart';
import 'profile_admin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ferrari App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => const RegisterScreen(),
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
        '/profile': (context) => const ProfileScreen(),
        '/personal-information': (context) => const PersonalInformationScreen(),
        '/my-orders': (context) => const MyOrdersScreen(),
        '/favorite-cars': (context) => const FavoriteCarsScreen(),

        '/admin-home': (context) => const AdminHomePage(),
        '/admin-catalog': (context) => AdminCatalogPage(),
        '/admin-profile': (context) => const AdminProfileScreen(), // Route Profile Admin
      },
    );
  }
}
