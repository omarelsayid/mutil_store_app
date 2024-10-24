import 'package:flutter/material.dart';
import 'widgets/banner_widget.dart';
import 'widgets/category_item_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/popular_product_widget.dart';
import 'widgets/reusable_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(),
          BannerWidget(),
          CategroyItemWidget(),
          ReusableTextWidget(tilte: 'Popular Products', subTilte: 'View all'),
          PopularProductWidget(),
        ],
      ),
    ));
  }
}
