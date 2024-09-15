import 'package:flutter/material.dart';
import 'package:multi_store_app/models/categroy_model.dart';
import 'package:multi_store_app/views/screens/detail/widgets/inner_category_content_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/account_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/cart_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/categroy_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/favourite_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/stores_screen.dart';

class InnerCategoryScreen extends StatefulWidget {
  const InnerCategoryScreen({super.key, required this.category});
  final Category category;
  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      InnerCategoryContentWidget(
        category: widget.category,
      ),
      const FavouriteScreen(),
      const CategoryScreen(),
      const StoresScreen(),
      const CartScreen(),
      AccountScreen(),
    ];

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
