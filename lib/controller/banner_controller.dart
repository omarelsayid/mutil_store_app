import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../global_variable.dart';
import '../models/banner_model.dart';

class BannerController {
  
  // this to upload banners to cloudniary then get the url and then post it in the DB
  
//fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      // send an http get reuest to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        // ok
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList(); // convert each map to a Banner object 
        return banners;
      } else {
        // throw an exception if the server respond with an error status code
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Error loading Banners $e');
    }
  }
}
