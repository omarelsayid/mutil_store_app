import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global_variable.dart';
import '../models/order.dart';
import '../services/manage_http_response.dart';

class OrderController {
  // function to upload orders

  uploadOrders({
    required BuildContext context,
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
  }) async {
    try {
      final Order order = Order(
        id: id,
        fullName: fullName,
        email: email,
        state: state,
        city: city,
        locality: locality,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        processing: processing,
        delivered: delivered,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/orders'),
        body: order.toJson(),
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

// Method to GET order by ID
  Future<List<Order>> loadOrders({required String buyerId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/$buyerId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      // check if the response status code is 200(OK).
      if (response.statusCode == 200) {
        // parse json into dynamic list
        // This convert the json data into a formate that can be further processed in dart
        List<dynamic> data = jsonDecode(response.body);
        // Map the dynamic list to List of orders object using fromJson factory
        // this step convert the raw data into list of orders object , which is easier to work with
        List<Order> orders =
            data.map((order) => Order.fromJson(order)).toList();
        return orders;
      } else {
        // throw an exciption for now if the server with an error status code
        throw Exception('failed to load orders');
      }
    } catch (e) {
      throw Exception('error in Loading Orders');
    }
  }

  Future<void> deleteOrder(
      {required String id, required BuildContext context}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/api/orders/$id'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Order Deleted sucessfully');
          });
    } catch (e) {
      log(e.toString());
    }
  }
}
