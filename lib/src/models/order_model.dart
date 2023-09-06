import 'dart:convert';

import 'product_model.dart';

class OrderModel {
  // blank final variable
  final String id;
  // Aggregation (has-a)
  final List<ProductModel> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  int status;
  final int totalPrice;
  OrderModel({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  // // association
  // void dd (ProductModel productModel){

  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'] ?? '',
      // Composition
      products: List<ProductModel>.from(
          map['products']?.map((x) => ProductModel.fromMap(x['product']))),
      quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
