import 'dart:convert';

import '../../../public/api_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/api_client.dart';

import 'package:http/http.dart' as http;

class UpdateProfileRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UpdateProfileRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<http.Response> saveUserData(
      String address, String name, String phone) async {
    return await apiClient.postData(
      ApiGateway.SAVE_USER_DATA,
      jsonEncode({
        'address': address,
        'name': name,
        'phone': phone,
      }),
    );
  }
}
