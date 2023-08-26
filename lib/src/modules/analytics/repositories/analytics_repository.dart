import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../public/api_gateway.dart';

class AnalyticsRepository extends GetConnect {
  final ApiClient apiClient;
  AnalyticsRepository({
    required this.apiClient,
  });

  Future<http.Response> fetchEarnings() async {
    return await apiClient.getData(ApiGateway.GET_EARNINGS);
  }
}
