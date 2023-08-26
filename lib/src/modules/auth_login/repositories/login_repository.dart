import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../models/user_model.dart';
import '../../../public/api_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../resources/base_repository.dart';

class LoginRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LoginRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });

  //sign in user
  Future<http.Response> login(String email, String password) async {
    return await apiClient.postData(
      ApiGateway.LOGIN,
      jsonEncode({
        'email': email,
        'password': password,
      }),
    );
  }

  // token is valid
  Future<http.Response> tokenIsValid() async {
    return await apiClient.postData(ApiGateway.IS_TOKEN_VALID, jsonEncode({}));
  }

  Future<UserModel?> getInfoUser({String? token}) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.GET_INFO,
      token: token,
    );
    if (response.statusCode == 200) {
      return UserModel.fromMap(response.data['data'] as Map<String, dynamic>);
    }
    return null;
  }

  // // get user data
  // Future<http.Response> getUserData() async {
  //   return await apiClient.getData(ApiGateway.GET_INFO);
  // }

  // save user token fCM
  Future<http.Response> saveUserTokenFCM(String tokenFCM) async {
    return await apiClient.postData(
      ApiGateway.SAVE_USER_TOKEN_FCM,
      jsonEncode({
        'tokenFCM': tokenFCM,
      }),
    );
  }

  // save user token
  Future<bool> saveUserToken(String tokenKey) async {
    apiClient.tokenKey = tokenKey;
    apiClient.updateHeaders(tokenKey);
    return await sharedPreferences.setString('token-key', tokenKey);
  }
  
  // save user token
  Future<bool> saveUserType(String type) async {
    return await sharedPreferences.setString('type-key', type);
  }
}
