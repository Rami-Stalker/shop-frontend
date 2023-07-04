import 'dart:convert';

import 'package:shop_app/app/core/network/api_constance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';

import '../../../core/utils/app_strings.dart';
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
      ApiConstance.sendOTP,
      jsonEncode({
        'phoneCode': phoneCode,
        'phoneNumber': phoneNumber,
      }),
    );
  }

  // verify OTP
  Future<http.Response> verifyOTP(String phoneCode, String phoneNumber, String codeOTP) async {
    return await apiClient.postData(
      ApiConstance.verifyOTP,
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
    );

    return await apiClient.postData(ApiConstance.signUp, user.toJson());
  }

  //sign in user
  Future<http.Response> login(String email, String password) async {
    return await apiClient.postData(
      ApiConstance.signIn,
      jsonEncode({
        'email': email,
        'password': password,
      }),
    );
  }

  // token is valid
  Future<http.Response> tokenIsValid() async {
    return await apiClient.postData(ApiConstance.isTokenValid, jsonEncode({}));
  }

  // get user data
  Future<http.Response> getUserData() async {
    return await apiClient.getData(ApiConstance.getUserData);
  }

  // save user token
  Future<bool> saveUserToken(String tokenKey) async {
    apiClient.tokenKey = tokenKey;
    apiClient.updateHeaders(tokenKey);
    return await sharedPreferences.setString(AppString.TOKEN_KEY, tokenKey);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppString.TOKEN_KEY) ?? '';
  }

  String getUserType() {
    return sharedPreferences.getString(AppString.TYPE_KEY) ?? '';
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppString.TOKEN_KEY);
  }
}
