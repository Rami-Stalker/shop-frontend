import 'dart:convert';

import '../../../public/api_gateway.dart';
import 'package:dio/dio.dart' as diox;


import '../../../core/api/base_repository.dart';
import '../../../models/product_model.dart';


class ProductDetailsRepository {
  final BaseRepository baseRepository;
  ProductDetailsRepository({
    required this.baseRepository,
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
