import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/favourite.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favouriteProvider =
    StateNotifierProvider<FavouriteNotifier, Map<String, Favourite>>((ref) {
  return FavouriteNotifier();
});

class FavouriteNotifier extends StateNotifier<Map<String, Favourite>> {
  FavouriteNotifier() : super({}) {
    _loadFavourite();
  }

  Future<void> _saveFavourite() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // Convert each Favourite object to a Map and encode the whole state
    Map<String, String> encodedFavourites = state.map((key, favourite) =>
      MapEntry(key, json.encode(favourite.toMap())));

    preferences.setString('favourite', json.encode(encodedFavourites));
  }

  Future<void> _loadFavourite() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('favourite') != null) {
      // Decode stored favourites and convert each entry back to a Favourite object
      Map<String, dynamic> favouriteMap = json.decode(preferences.getString('favourite')!);
      final favourite = favouriteMap.map(
        (key, value) => MapEntry(
          key,
          Favourite.fromMap(json.decode(value)),
        ),
      );
      state = favourite;
    }
  }

  void addFavourite({
    required final String productName,
    required final int productPrice,
    required final String category,
    required final List<String> image,
    required final String vendorId,
    required final int productQuantity,
    required int quantity,
    required final String productId,
    required final String productDescription,
    required final String fullName,
  }) {
    state[productId] = Favourite(
        productName: productName,
        productPrice: productPrice,
        category: category,
        image: image,
        vendorId: vendorId,
        productQuantity: productQuantity,
        quantity: quantity,
        productId: productId,
        productDescription: productDescription,
        fullName: fullName);

    state = {...state};
    _saveFavourite();
  }

  Map<String, Favourite> get favouriteItems => {...state};

  void removeFavourite(String productId) {
    state.remove(productId);
    state = {...state};
    _saveFavourite();
  }
}
