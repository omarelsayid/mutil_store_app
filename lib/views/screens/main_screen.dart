import 'package:flutter/material.dart';
import 'package:multi_store_app/views/screens/nav_screens/account_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/cart_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/categroy_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/favourite_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/home_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const FavouriteScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (value) => setState(() {
          _pageIndex = value;
        }),
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                height: 25,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/love.png', height: 25),
              label: 'Favourite'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/mart.png', height: 25),
              label: 'Stores'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/cart.png',
                height: 25,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/user.png',
                height: 25,
              ),
              label: 'Account'),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
