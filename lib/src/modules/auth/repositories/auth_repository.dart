import 'dart:async';

import 'package:shop_app/src/resources/base_repository.dart';

import '../../../models/user_model.dart';
import '../../../public/api_gateway.dart';
import 'package:dio/dio.dart' as diox;

import '../../../resources/local/user_local.dart';

class AuthRepository {
  final BaseRepository baseRepository;
  AuthRepository({
    required this.baseRepository,
  });

  Future<UserModel?> register({
    required String image,
    required String blurHash,
    required String name,
    required String email,
    required String password,
    required String phone,
    String? token,
  }) async {
    var body = {
      'image': image,
      'blurHash': blurHash,
      'name': name.toLowerCase(),
      'email': email,
      'password': password,
      'phone': phone,
    };
    diox.Response response =
        await baseRepository.postRoute(ApiGateway.REGISTER, body);

        print(response.data);

    if ([200, 201].contains(response.statusCode)) {
      return UserModel.fromMap(response.data as Map<String, dynamic>);
    }
    return null;
  }

  Future<diox.Response> login(String email, String password,
      {String? token}) async {
    var body = {
      "email": email.toLowerCase(),
      "password": password,
    };
    return await baseRepository.postRoute(
      ApiGateway.LOGIN,
      body,
      token: token,
    );
  }

  Future<diox.Response> isTokenValid() async {
    return await baseRepository.postRoute(
      ApiGateway.IS_TOKEN_VALID,
      {},
    );
  }

  // send OTP
  Future<diox.Response> sendOtP(String phoneCode, String phoneNumber,
      {String? token}) async {
    var body = {
      'phoneCode': phoneCode,
      'phoneNumber': phoneNumber,
    };
    return await baseRepository.postRoute(
      ApiGateway.SEND_OTP,
      body,
    );
  }

  // verify OTP
  Future<diox.Response> verifyOTP(
      String phoneCode, String phoneNumber, String codeOTP,
      {String? token}) async {
    var body = {
      'phoneCode': phoneCode,
      'phoneNumber': phoneNumber,
      'codeOTP': codeOTP,
    };
    return await baseRepository.postRoute(
      ApiGateway.VERIFY_OTP,
      body,
    );
  }

  Future<diox.Response> getInfoUser({String? token}) async {
    return await baseRepository.getRoute(
      ApiGateway.GET_INFO,
      token: token,
    );
  }

  // Future<UserModel?> updateAvatar({
  //   required String avatar,
  //   required String blurHash,
  // }) async {
  //   var body = {
  //     "blurHash": blurHash,
  //     "image": avatar,
  //   };
  //   diox.Response response = await BaseRepository().patchRoute(
  //     ApiGateway.UPDATE_AVATAR,
  //     body: body,
  //   );
  //   if ([200, 201].contains(response.statusCode)) {
  //     return UserModel.fromMap(response.data['data'] as Map<String, dynamic>);
  //   }
  //   return null;
  // }

  // save user token fCM
  Future<diox.Response> saveUserTokenFCM(String tokenFCM) async {
    var body = {
      "tokenFCM": tokenFCM,
    };
    return await baseRepository.postRoute(
      ApiGateway.SAVE_USER_TOKEN_FCM,
      body,
    );
  }

  FutureOr<bool> logOut() async {
    UserLocal().clearAccessToken();
    return false;
  }
}
