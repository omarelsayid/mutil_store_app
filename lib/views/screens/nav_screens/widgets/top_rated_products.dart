import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../provider/top_rated_products.dart';
import '../../../../controller/product_controller.dart';
import '../../../../provider/product_provider.dart';
import 'product_item_widget.dart';

class TopRatedProducts extends ConsumerStatefulWidget {
  const TopRatedProducts({super.key});

  @override
  ConsumerState<TopRatedProducts> createState() => _TopRatedProductsState();
}

class _TopRatedProductsState extends ConsumerState<TopRatedProducts> {
  // future that will hold the list of poular products
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadTopRatedProducts();
      ref.read(topRatedProductProvider.notifier).setProducts(products);
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(topRatedProductProvider);
    return SizedBox(
      height: 250,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItemWidget(
                  product: product,
                );
              },
            ),
    );
  }
}
