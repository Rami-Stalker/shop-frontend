import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../core/network/api_constance.dart';
import '../../../models/order_model.dart';

class AdminOrderRepository extends GetConnect {
  final ApiClient apiClient;
  AdminOrderRepository({
    required this.apiClient,
  });

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
}
