import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../core/network/api_constance.dart';
import '../../../models/order_model.dart';
import '../../../models/product_model.dart';

class AdminRepository extends GetConnect {
  final ApiClient apiClient;
  AdminRepository({
    required this.apiClient,
  });

  Future<http.Response> addProduct({
    required ProductModel product,
  }) async {
    return await apiClient.postData(ApiConstance.addProduct, product.toJson());
  }

  Future<http.Response> fetchAllProducts() async {
    return await apiClient.getData(ApiConstance.getProducts);
  }

  Future<http.Response> fetchCategoryProduct({
    required String category,
  }) async {
    return await apiClient.getData('${ApiConstance.category}$category');
  }

  Future<http.Response> deleteProduct({
    required ProductModel product,
  }) async {
    return await apiClient.postData(
      ApiConstance.deleteProduct,
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
      ApiConstance.updateProduct,
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

  Future<http.Response> fetchAllOrders() async {
    return await apiClient.getData(ApiConstance.getAllOrder);
  }

  Future<http.Response> changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    return await apiClient.postData(
        ApiConstance.changeOrderStatus,
        jsonEncode({
          "id": order.id,
          "status": status,
        }));
  }

  Future<http.Response> deleteOrder({
    required OrderModel order,
  }) async {
    return await apiClient.postData(
      ApiConstance.deleteOrder,
      jsonEncode(
        {"id": order.id},
      ),
    );
  }

  Future<http.Response> fetchEarnings() async {
    return await apiClient.getData(ApiConstance.getEarnings);
  }
}
