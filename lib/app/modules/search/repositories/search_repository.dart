import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';

import '../../../core/network/api_constance.dart';

class SearchRepository {
  final ApiClient apiClient;
  SearchRepository({
    required this.apiClient,
  });
  Future<http.Response> fetchSearchProduct({
    required String searchQuery,
  }) async {
    return await apiClient.getData(
      '${ApiConstance.productsSearch}$searchQuery',
      );
  }
}
