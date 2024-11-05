import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../global_variable.dart';
import '../models/product.dart';

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('auth_token');

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/popular-products'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
          'X-auth-token': '$token',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        // the response will be a list when we decode it we just need to use from map
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<Product> categories = data
            .map(
                (category) => Product.fromMap(category as Map<String, dynamic>))
            .toList();
        return categories;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      log('Error: $e');
      // Returning an empty list to handle errors gracefully
      return [];
    }
  }

  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        // the response will be a list when we decode it we just need to use from map
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<Product> categories = data
            .map(
                (category) => Product.fromMap(category as Map<String, dynamic>))
            .toList();
        return categories;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      log('Error: $e');
    }
    return [];
  }

  Future<List<Product>> loadRelatedProductsBySubcategory(
      String productId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/related-products-by-subcategory/$productId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        // the response will be a list when we decode it we just need to use from map
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<Product> relatedProducts = data
            .map(
                (category) => Product.fromMap(category as Map<String, dynamic>))
            .toList();
        return relatedProducts;
      } else {
        throw Exception('Failed to load related products');
      }
    } catch (e) {
      log('Error: $e');
    }
    return [];
  }

  Future<List<Product>> loadTopRatedProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/top-rated-products'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        // the response will be a list when we decode it we just need to use from map
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<Product> topRatedProducts = data
            .map(
                (category) => Product.fromMap(category as Map<String, dynamic>))
            .toList();
        return topRatedProducts;
      } else {
        throw Exception('Failed to load related products');
      }
    } catch (e) {
      log('Error: $e');
    }
    return [];
  }
}
