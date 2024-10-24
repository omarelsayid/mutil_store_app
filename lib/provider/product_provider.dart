import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class ProductProvider extends StateNotifier<List<Product>> {
  ProductProvider() : super([]);

  // set the List of product

  void setProduct(List<Product> products) {
    state = products;
  }
}
final productProvider=StateNotifierProvider<ProductProvider,List<Product>>(
  (ref){
    return ProductProvider();
  }
);