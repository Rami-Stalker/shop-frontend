import 'dart:convert';

import 'package:shop_app/app/core/network/api_constance.dart';
import 'package:http/http.dart' as http;


import '../../../core/api/api_client.dart';
import '../../../models/product_model.dart';


class ProductDetailsRepository {
  final ApiClient apiClient;
  ProductDetailsRepository({
    required this.apiClient,
  });
  Future<http.Response> addToCart({
    required ProductModel product,
    required int ord,
  }) async {
    return await apiClient.postData(ApiConstance.updateProductQuantity, jsonEncode({
      'id': product.id,
      'ord': ord,
    }));
  }

  Future<http.Response> rateProduct({
    required ProductModel product,
    required double rating,
  }) async {
    return await apiClient.postData(ApiConstance.rateProduct, jsonEncode({
      "id": product.id,
      "rating": rating,
    }));
  }
}
