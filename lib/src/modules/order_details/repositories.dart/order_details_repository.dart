import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../models/order_model.dart';
import '../../../public/api_gateway.dart';

class OrderDetailsRepository {
  final ApiClient apiClient;
  OrderDetailsRepository({
    required this.apiClient,
  });

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
