import 'dart:convert';

import 'product_model.dart';
import 'rating_model.dart';

class CartModel {
  String? id;
  int? price;
  String? image;
  String? name;
  int? userQuant;
  bool? isExist;
  String? time;
  ProductModel? product;
  List<RatingModel>? rating;

  CartModel({
    this.id,
    this.price,
    this.image,
    this.name,
    this.userQuant,
    this.isExist,
    this.time,
    this.product,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'image': image,
      'name': name,
      'quantity': userQuant,
      'isExist': isExist,
      'time': time,
      'product': product?.toMap(),
      'rating': rating?.map((x) => x.toMap()).toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      price: map['price'],
      image: map['image'],
      name: map['name'],
      userQuant: map['quantity']?.toInt(),
      isExist: map['isExist'],
      time: map['time'],
      product: map['product'] != null ? ProductModel.fromMap(map['product']) : null,
      rating: map['rating'] != null
            ? List<RatingModel>.from(
                map['rating']?.map(
                  (x) => RatingModel.fromMap(x),
                ),
              )
            : null
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source));
}
