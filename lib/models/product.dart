import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final String subCategory;
  final List<String> images;
  final double avrageRating;  // Corrected name
  final int totalRatings;

  Product(
      {required this.avrageRating,  // Corrected name
      required this.totalRatings,
      required this.id,
      required this.productName,
      required this.productPrice,
      required this.quantity,
      required this.description,
      required this.category,
      required this.vendorId,
      required this.fullName,
      required this.subCategory,
      required this.images});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'subCategory': subCategory,
      'images': images,
      'avrageRating': avrageRating,  // Corrected name
      'totalRatings': totalRatings,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      quantity: map['quantity'] as int,
      description: map['description'] as String,
      category: map['category'] as String,
      vendorId: map['vendorId'] as String,
      fullName: map['fullName'] as String,
      subCategory: map['subCategory'] as String,
      images: List<String>.from(
        (map['images'] as List<dynamic>),
      ),
      avrageRating: (map['avrageRating'] is int  // Corrected name
          ? (map['avrageRating'] as int).toDouble()
          : map['avrageRating'] as double),
      totalRatings: map['totalRatings'] as int,  // Ensure correct type casting
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
