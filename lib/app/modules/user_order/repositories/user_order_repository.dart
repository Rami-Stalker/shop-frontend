import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../core/network/api_constance.dart';

class UserOrderRepository {
  final ApiClient apiClient;
  UserOrderRepository({
    required this.apiClient,
  });

  Future<http.Response> fetchMyOrder() async {
    return await apiClient.getData(ApiConstance.getUserOrder);
  }
}
