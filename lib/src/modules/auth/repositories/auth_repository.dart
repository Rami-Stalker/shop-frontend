import 'dart:convert';

import 'package:shop_app/src/public/api_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';

import '../../../models/user_model.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });

  // send OTP
  Future<http.Response> sendOtP(String phoneCode, String phoneNumber) async {
    return await apiClient.postData(
      ApiGateway.SEND_OTP,
      jsonEncode({
        'phoneCode': phoneCode,
        'phoneNumber': phoneNumber,
      }),
    );
  }

  // verify OTP
  Future<http.Response> verifyOTP(
      String phoneCode, String phoneNumber, String codeOTP) async {
    return await apiClient.postData(
      ApiGateway.VERIFY_OTP,
      jsonEncode({
        'phoneCode': phoneCode,
        'phoneNumber': phoneNumber,
        'codeOTP': codeOTP,
      }),
    );
  }

  // sign up user
  Future<http.Response> signUpUser({
    required String photo,
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    UserModel user = UserModel(
      id: '',
      photo: photo,
      name: name,
      email: email,
      password: password,
      phone: phone,
      address: '',
      type: '',
      token: '',
      tokenFCM: '',
    );

    return await apiClient.postData(ApiGateway.REGISTER, user.toJson());
  }

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

  // get user data
  Future<http.Response> getUserData() async {
    return await apiClient.getData(ApiGateway.USER);
  }

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

  String getUserToken() {
    return sharedPreferences.getString('token-key') ?? '';
  }


  // save user token
  Future<bool> saveUserType(String type) async {
    return await sharedPreferences.setString('type-key', type);
  }

  String getUserType() {
    return sharedPreferences.getString('type-key') ?? '';
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey('token-key');
  }
}
