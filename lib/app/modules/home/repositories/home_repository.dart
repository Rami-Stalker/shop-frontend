import 'package:shop_app/app/core/network/api_constance.dart';
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
    return await apiClient.getData('${ApiConstance.category}$category');
  }

  Future<http.Response> fetchRatingProduct() async {
    return await apiClient.getData(ApiConstance.getRatingProducts);
  }

  Future<http.Response> fetchAllProduct() async {
    return await apiClient.getData(ApiConstance.getNewestProducts);
  }
}
