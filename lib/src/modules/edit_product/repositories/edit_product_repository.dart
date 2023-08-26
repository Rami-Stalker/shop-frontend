import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../public/api_gateway.dart';
import '../../../models/product_model.dart';

class EditProductRepository extends GetConnect {
  final ApiClient apiClient;
  EditProductRepository({
    required this.apiClient,
  });

  Future<http.Response> deleteProduct({
    required ProductModel product,
  }) async {
    return await apiClient.postData(
      ApiGateway.DELETE_PRODUCT,
      jsonEncode(
        {
          "id": product.id,
        },
      ),
    );
  }

  Future<http.Response> updateProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
  }) async {
    return await apiClient.postData(
      ApiGateway.UPDATE_PRODUCT,
      jsonEncode(
        {
          "id": id,
          "name": name,
          "description": description,
          "price": price,
          "quantity": quantity,
        },
      ),
    );
  }
}
