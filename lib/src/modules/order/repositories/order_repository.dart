import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../public/api_gateway.dart';

class OrderRepository {
  final ApiClient apiClient;
  OrderRepository({
    required this.apiClient,
  });

  Future<http.Response> fetchAllOrders() async {
    return await apiClient.getData(ApiGateway.GET_ORDERS);
  }

  Future<http.Response> fetchUserOrder() async {
    return await apiClient.getData(ApiGateway.GET_ORDERS_BY_ID);
  }
}
