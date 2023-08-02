import 'dart:convert';

import 'package:shop_app/src/public/api_gateway.dart';

import '../../../core/api/api_client.dart';
import 'package:http/http.dart' as http;


class CheckoutRepository {
  final ApiClient apiClient;
  CheckoutRepository({
    required this.apiClient,
  });

  Future<http.Response> checkout({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    return await apiClient.postData(
      ApiGateway.ADD_ORDER,
      jsonEncode({
        'productsId': productsId,
        'userQuants': userQuants,
        'totalPrice': totalPrice,
        'address': address,
      }),
    );
  }
}
