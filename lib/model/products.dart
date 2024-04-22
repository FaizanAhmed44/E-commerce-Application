import 'dart:convert';

import 'package:amazon_clone/model/Rating.dart';

class ProductModel {
  final String name;
  final String description;
  final String category;
  final List<String> images;
  final double quantity;
  final double price;
  final String? id;
  final List<Rating>? rating;

  ProductModel({
    required this.name,
    required this.description,
    required this.category,
    required this.images,
    required this.quantity,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'price': price,
      'category': category,
      'id': id,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
