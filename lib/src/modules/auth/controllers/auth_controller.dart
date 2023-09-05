import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/resources/remote/user_repository.dart';
import 'package:shop_app/src/routes/app_pages.dart';
import '../../../models/upload_response_model.dart';
import '../../../resources/local/user_local.dart';
import '../../../resources/remote/upload_repository.dart';
import '../../../routess/app_routes.dart';
import '../repositories/auth_repository.dart';

import '../../../public/components.dart';

import '../../../public/constants.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? userModel;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
  }

  void sendOtP({
    required String phoneCode,
    required String phoneNumber,
  }) async {
    try {
      diox.Response response =
          await authRepository.sendOtP(phoneCode, phoneNumber);
      Constants.handleApi(
        response: response,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "OTP");
    }
  }

  void register({
    required File? avatar,
    required String name,
    required String email,
    required String password,
    required String phoneCode,
    required String phoneNumber,
    required String codeOTP,
  }) async {
    try {
      _isLoading = true;
      update();
      if (avatar != null) {
        UploadResponseModel? response =
            await UploadRepository().uploadSingleFile(file: avatar);

        if (response != null) {
          UserModel? user = await authRepository.register(
            image: response.image,
            blurHash: response.blurHash,
            name: name,
            email: email,
            password: password,
            phone: phoneNumber,
          );
          if (user != null) {
            userModel = user;
            UserLocal().saveAccessToken(user.token);
            UserLocal().saveUserType(user.type);
            UserLocal().saveUserId(user.id);
            AppNavigator.push(Routes.NAVIGATION);
          }
        }
      }
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      Components.showSnackBar(e.toString(), title: "Register");
    }
  }

  void login(String email, String password) async {
    try {
      _isLoading = true;
      update();
      diox.Response response = await authRepository.login(
        email,
        password,
      );

      Constants.handleApi(
        response: response,
        onSuccess: () {
          userModel = UserModel.fromMap(response.data as Map<String, dynamic>);
          UserLocal().saveUserId(response.data['_id']);
          UserLocal().saveAccessToken(response.data['token']);
          UserLocal().saveUserType(response.data['type']);
          AppNavigator.replaceWith(Routes.NAVIGATION);
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      Components.showSnackBar(e.toString(), title: "Login");
    }
  }

  void GetInfoUser() async {
    try {
      diox.Response tokenResponse = await authRepository.isTokenValid();

      Constants.handleApi(
        response: tokenResponse,
        onSuccess: () async {
          bool isTokenValid = tokenResponse.data;
          if (isTokenValid) {
            diox.Response response = await authRepository.getInfoUser();
            Constants.handleApi(
              response: response,
              onSuccess: () {
                UserModel user =
                    UserModel.fromMap(response.data as Map<String, dynamic>);
                userModel = user;
                UserLocal().saveUser(user);
              },
            );
          }
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Get Info User");
    }
  }

  Future<void> updateAvatar({
    required File avatar,
  }) async {
    try {
      UploadResponseModel? response =
          await UploadRepository().uploadSingleFile(file: avatar);
      if (response != null) {
        UserModel? user = await UserRepository().updateAvatar(
          avatar: response.image,
          blurHash: response.blurHash,
        );
        if (user != null) {
          userModel = user;
        }
      }
      AppNavigator.pop();
      update();
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "upload image");
    }
  }

  bool onAuthCheck() {
    UserModel? userLocal = UserLocal().getUser();
    if (userLocal != null) {
      userModel = userLocal;
    }
    return UserLocal().getAccessToken() != '';
  }

  Future<void> logOut() async {
    try {
      AppGet.CartGet
        ..clear()
        ..clearCartHistory();
      // await FirebaseMessaging.instance.deleteToken();
      await authRepository.logOut();
      AppNavigator.push(Routes.NAVIGATION);
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    await UserRepository().deleteAccount();
    AppNavigator.popUntil(AppRoutes.ROOT);
    logOut();
  }

  void saveUserTokenFCM(String tokenFCM) async {
    try {
      diox.Response res = await authRepository.saveUserTokenFCM(tokenFCM);
      Constants.handleApi(
        response: res,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
