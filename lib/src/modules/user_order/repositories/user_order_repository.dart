import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../public/api_gateway.dart';

class UserOrderRepository {
  final ApiClient apiClient;
  UserOrderRepository({
    required this.apiClient,
  });

  Future<http.Response> fetchMyOrder() async {
    return await apiClient.getData(ApiGateway.GET_ORDERS_BY_ID);
  }
}
