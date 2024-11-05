import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class RelatedProductsProvider extends StateNotifier<List<Product>> {
  RelatedProductsProvider() : super([]);

  // set the List of product

  void setProduct(List<Product> products) {
    state = products;
  }
}

final relatedProductsProvider =
    StateNotifierProvider<RelatedProductsProvider, List<Product>>((ref) {
  return RelatedProductsProvider();
});
