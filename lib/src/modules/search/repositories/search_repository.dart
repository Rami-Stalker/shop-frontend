import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../public/api_gateway.dart';

class SearchRepository {
  final ApiClient apiClient;
  SearchRepository({
    required this.apiClient,
  });
  Future<http.Response> fetchSearchProduct({
    required String searchQuery,
  }) async {
    return await apiClient.getData(
      '${ApiGateway.GET_SEARCH}$searchQuery',
      );
  }
}
