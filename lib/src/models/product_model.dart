import 'dart:convert';

import 'rating_model.dart';

class ProductModel {
  final String? id;
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final int price;
  final int? oldPrice;
  final int? discount;
  List<RatingModel>? ratings;
  final String time;
  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.oldPrice,
    this.discount,
    this.ratings,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'oldPrice': oldPrice,
      'discount': discount,
      'ratings': ratings,
      'time': time,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price'] ?? 0,
      oldPrice: map['oldPrice'] ?? 0,
      discount: map['discount'] ?? 0,
      ratings: map['ratings'] != null
          ? List<RatingModel>.from(
              map['ratings']?.map(
                (x) => RatingModel.fromMap(x),
              ),
            )
          : null,
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
