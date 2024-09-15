import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_store_app/provider/user_provider.dart';
import 'package:multi_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:multi_store_app/views/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Run the flutter wrapped in providerScope for managing state.

  runApp(const ProviderScope(child: MyApp()));
}

// Root widget of the application , a consumerWidget to consume state change

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  //Method to check the token abd set the user dataa if

  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    // Obtain an instance of SharedPreferences for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Retrieve the authentication token and user data stored locally
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    // If both token and user data are available, update the user state
    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).singOut();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = ref.watch(userProvider);
          return user != null ? const MainScreen() : const LoginScreen();
        },
      ),
    );
  }
}
