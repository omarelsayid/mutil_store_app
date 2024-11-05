// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Favourite {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> image;
  final String vendorId;
  final int productQuantity;
  int quantity;
  final String productId;
  final String productDescription;
  final String fullName;

  Favourite({
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.image,
    required this.vendorId,
    required this.productQuantity,
    required this.quantity,
    required this.productId,
    required this.productDescription,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productPrice': productPrice,
      'category': category,
      'image': image,
      'vendorId': vendorId,
      'productQuantity': productQuantity,
      'quantity': quantity,
      'productId': productId,
      'productDescription': productDescription,
      'fullName': fullName,
    };
  }

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      category: map['category'] as String,
      image: List<String>.from(map['image'] as List),
      vendorId: map['vendorId'] as String,
      productQuantity: map['productQuantity'] as int,
      quantity: map['quantity'] as int,
      productId: map['productId'] as String,
      productDescription: map['productDescription'] as String,
      fullName: map['fullName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favourite.fromJson(String source) => Favourite.fromMap(json.decode(source) as Map<String, dynamic>);
}
