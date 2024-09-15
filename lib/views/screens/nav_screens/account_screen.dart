import 'package:flutter/material.dart';
import 'package:multi_store_app/controller/auth_controller.dart';
import 'package:multi_store_app/views/screens/detail/screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const OrderScreen();
                  },
                ),
              );
            },
            child: const Text('My orddrs')),
      ),
    );
  }
}
