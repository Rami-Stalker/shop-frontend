import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../public/api_gateway.dart';
import '../../../models/order_model.dart';

class AdminOrderRepository extends GetConnect {
  final ApiClient apiClient;
  AdminOrderRepository({
    required this.apiClient,
  });

  Future<http.Response> fetchAllOrders() async {
    return await apiClient.getData(ApiGateway.GET_ORDERS);
  }

  Future<http.Response> changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    return await apiClient.postData(
        ApiGateway.CHANGE_ORDER_STATUS,
        jsonEncode({
          "id": order.id,
          "status": status,
        }));
  }

  Future<http.Response> deleteOrder({
    required OrderModel order,
  }) async {
    return await apiClient.postData(
      ApiGateway.DELETE_ORDER,
      jsonEncode(
        {"id": order.id},
      ),
    );
  }
}
