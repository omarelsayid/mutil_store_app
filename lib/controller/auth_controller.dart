import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../global_variable.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../provider/user_provider.dart';
import '../services/manage_http_response.dart';
import '../views/screens/authentication_screens/login_screen.dart';
import '../views/screens/main_screen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

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
                  builder: (context) => const LoginScreen(),
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
          onSuccess: () async {
            // sharedPrefrences for token and user data storage
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            // extract the authentication token from response body
            String token = jsonDecode(response.body)['token'];

            // SOTRE the authentication token secuerly in sharedPrefrences
            await preferences.setString('auth_token', token);

            // Encode the user data recive from backend as sjon
            final userJson = jsonEncode(jsonDecode(response.body)['user']);
            log(userJson);
            // update the application state with user data using Riverpod
            providerContainer.read(userProvider.notifier).setUser(userJson);

            // store the data in shared prefrence for future use
            await preferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
                (route) => false);
            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      log('Error:$e');
    }
  }

//signout

  Future<void> singOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // clear the token and user from the shared prefrences
      await preferences.remove('auth_token');
      await preferences.remove('user');
      providerContainer.read(userProvider.notifier).singOut();

      // navigate tje user back to login screen
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ), (route) => false);

      showSnackBar(context, 'signout sucessfully');
    } catch (e) {
      showSnackBar(context, 'error in siging out');
    }
  }

// update user's state ,city and locality
  Future<void> updateUserLocation({
    required BuildContext context,
    required String id,
    required String state,
    required String city,
    required String locality,
  }) async {
    try {
      // Make an HTTP requset to update user's state , city and locality
      final http.Response response = await http.put(
        Uri.parse('$uri/api/users/$id'),
        // Encode the Updated data (state,city,locality) AS Json Object
        body: json.encode(
          {
            'state': state,
            'city': city,
            'locality': locality,
          },
        ),

        // set the headers for the rquest to specify that contect in Json
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          //Decode the updated user data from the response body
          //this converts the json String response into Dart Map
          log('onsuccess');
          final updatedUser = jsonDecode(response.body);
          //Access Shared preference for local data storage
          //shared preferences allow us to store data persisitently on the the device
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //Encode the update user data as json String
          //this prepares the data for storage in shared preference
          final userJson = jsonEncode(updatedUser);

          //update the application state with the updated user data  using Riverpod
          //this ensures the app reflects the most recent user data

          log('i am working');
          providerContainer.read(userProvider.notifier).setUser(userJson);

          //store the updated user data in shared preference  for future user
          //this allows the app to retrive the user data  even after the app restarts
          log('i am working');

          await preferences.setString('user', userJson);
        },
      );
    } catch (e) {
      showSnackBar(context, 'Error updating location');
    }
  }
}
