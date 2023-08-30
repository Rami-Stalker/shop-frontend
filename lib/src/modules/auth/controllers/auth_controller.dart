import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/routes/app_pages.dart';
import '../../../resources/local/user_local.dart';
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
      Components.showSnackBar(e.toString());
    }
  }

  void register({
    required File? photo,
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
      String photoCloud = '';
      if (photo != null) {
        final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
        int random = Random().nextInt(1000);

        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            photo.path,
            folder: "$name $random",
          ),
        );
        photoCloud = res.secureUrl;
      } else {
        photoCloud =
            "https://asota.umobile.edu/wp-content/uploads/2021/08/Person-icon.jpeg";
      }
      diox.Response response = await authRepository.register(
        photo: photoCloud,
        name: name,
        email: email,
        password: password,
        phone: phoneNumber,
      );

      Constants.handleApi(
        response: response,
        onSuccess: () {
          userModel = UserModel.fromMap(response.data as Map<String, dynamic>);
          UserLocal().saveAccessToken(response.data['token']);
          UserLocal().saveUserType(response.data['type']);
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      Components.showSnackBar(e.toString(), title: "catch");
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
          UserLocal().saveAccessToken(response.data['token']);
          UserLocal().saveUserType(response.data['type']);
          Get.toNamed(Routes.NAVIGATION);
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      Components.showSnackBar(e.toString(), title: "catch");
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
      Components.showSnackBar(e.toString());
    }
  }

  bool onAuthCheck() {
    UserModel? userLocal = UserLocal().getUser();
    if (userLocal != null) {
      userModel = userLocal;
    }
    return UserLocal().getAccessToken() != '';
  }

  Future<bool> logOut() async {
    AppGet.CartGet..clear()..clearCartHistory();
    await FirebaseMessaging.instance.deleteToken();
    await authRepository.logOut();
    Get.toNamed(Routes.NAVIGATION);
    update();
    return true;
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
