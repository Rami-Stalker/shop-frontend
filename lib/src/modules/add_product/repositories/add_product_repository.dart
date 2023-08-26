import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../models/product_model.dart';
import '../../../public/api_gateway.dart';

class AddProductRepository extends GetConnect {
  final ApiClient apiClient;
  AddProductRepository({
    required this.apiClient,
  });

  Future<http.Response> addProduct({
    required ProductModel product,
  }) async {
    return await apiClient.postData(ApiGateway.ADD_PRODUCT, product.toJson());
  }
}
