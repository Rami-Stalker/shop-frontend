import 'dart:convert';

import '../../../public/api_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';

import '../../../models/user_model.dart';

class RegisterRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  RegisterRepository({
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
}
