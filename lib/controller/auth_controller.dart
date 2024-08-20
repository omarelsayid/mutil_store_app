import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_store_app/global_variable.dart';
import 'package:multi_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/services/manage_http_response.dart';
import 'package:multi_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:multi_store_app/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        token: '',
        id: '',
        password: password,
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
      );

      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(), // convert the user object to request body
          headers: <String, String>{
            // set the Headers for the request
            "Content-Type":
                'application/json; charset=UTF-8', //specify the content type as json
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
            showSnackBar(context, 'Account has been Created for You');
          });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: json.encode(
          {
            'email': email, // include the email the request body
            'password': password, // include the email the request body
          },
        ),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      //handle the response using manageHttpresponse

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
                (route) => false);
            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      log('Error:' + e.toString());
    }
  }
}
