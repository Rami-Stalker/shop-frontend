import '../../../public/api_gateway.dart';
import 'package:http/http.dart' as http;


import '../../../core/api/api_client.dart';

class CategoryRepository {
  final ApiClient apiClient;
  CategoryRepository({
    required this.apiClient,
  });

  Future<http.Response> fetchCategoryProduct({
    required String category,
  }) async {
    return await apiClient.getData('${ApiGateway.GET_CATEGORY}$category');
  }
}
