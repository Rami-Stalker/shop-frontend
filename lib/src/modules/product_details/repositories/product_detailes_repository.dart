import 'dart:convert';

import '../../../public/api_gateway.dart';
import 'package:http/http.dart' as http;


import '../../../core/api/api_client.dart';
import '../../../models/product_model.dart';


class ProductDetailsRepository {
  final ApiClient apiClient;
  ProductDetailsRepository({
    required this.apiClient,
  });

  // Future<http.Response> rateProduct({
  //   required ProductModel product,
  //   required double rating,
  // }) async {
  //   return await apiClient.postData(ApiConstance.RATE_PRODUCT, jsonEncode({
  //     "id": product.id,
  //     "rating": rating,
  //   }));
  // }
}
