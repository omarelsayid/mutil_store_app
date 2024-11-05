import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global_variable.dart';
import '../models/product_review.dart';
import '../services/manage_http_response.dart';

class ProductReviewController {
  Future<void> uploadReview(
      {required String review,
      required String productId,
      required String fullName,
      required String email,
      required double rating,
      required String buyerId,
      required BuildContext context}) async {
    try {
      ProductReview productReview = ProductReview(
          buyerId: buyerId,
          id: '',
          review: review,
          productId: productId,
          fullName: fullName,
          email: email,
          rating: rating);
      http.Response response = await http.post(
        Uri.parse('$uri/api/product-review'),
        body: productReview.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'You Have placed an order');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
