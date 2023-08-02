import 'package:shop_app/src/public/api_gateway.dart';
import 'package:http/http.dart' as http;


import '../../../core/api/api_client.dart';

class HomeRepository {
  final ApiClient apiClient;
  HomeRepository({
    required this.apiClient,
  });

  Future<http.Response> fetchCategoryProduct({
    required String category,
  }) async {
    return await apiClient.getData('${ApiGateway.GET_CATEGORY}$category');
  }

  Future<http.Response> fetchRatingProduct() async {
    return await apiClient.getData(ApiGateway.GET_RATING);
  }

  Future<http.Response> fetchNewestProduct() async {
    return await apiClient.getData(ApiGateway.GET_NEWEST);
  }
}
