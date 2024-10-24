import 'dart:convert';

class ProductReview {
  final String buyerId; // ID of the user who bought the product
  final String id; // Review ID
  final String review; // The actual review content
  final String productId; // Product the review is associated with
  final String fullName; // Name of the reviewer
  final String email; // Email of the reviewer
  final double rating; // Rating given by the reviewer

  ProductReview({
    required this.buyerId,
    required this.id,
    required this.review,
    required this.productId,
    required this.fullName,
    required this.email,
    required this.rating,
  });

  // Converts the object to a map (for serialization)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buyerId': buyerId,
      'id': id,
      'review': review,
      'productId': productId,
      'fullName': fullName,
      'email': email,
      'rating': rating,
    };
  }

  // Factory constructor to create a ProductReview object from a map
  factory ProductReview.fromMap(Map<String, dynamic> map) {
    return ProductReview(
      buyerId: map['buyerId'] as String,
      id: map['_id'] as String,
      review: map['review'] as String,
      productId: map['productId'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      rating: map['rating'] as double,
    );
  }

  // Converts the object to a JSON string
  String toJson() => json.encode(toMap());

  // Factory constructor to create a ProductReview object from JSON
  factory ProductReview.fromJson(String source) =>
      ProductReview.fromMap(json.decode(source) as Map<String, dynamic>);
}
