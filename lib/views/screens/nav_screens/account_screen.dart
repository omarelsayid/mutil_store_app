import 'package:flutter/material.dart';
import 'package:multi_store_app/controller/auth_controller.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await _authController.singOutUser(context: context);
            },
            child: const Text('signOut')),
      ),
    );
  }
}
