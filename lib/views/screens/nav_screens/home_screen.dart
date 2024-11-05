import 'package:flutter/material.dart';
import 'widgets/top_rated_products.dart';
import 'widgets/banner_widget.dart';
import 'widgets/category_item_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/popular_product_widget.dart';
import 'widgets/reusable_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
          child: const HeaderWidget(),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              BannerWidget(),
              CategroyItemWidget(),
              ReusableTextWidget(
                  tilte: 'Popular Products', subTilte: 'View all'),
              PopularProductWidget(),
              ReusableTextWidget(
                  tilte: 'top rated Products', subTilte: 'View all'),
              TopRatedProducts()
            ],
          ),
        ));
  }
}
