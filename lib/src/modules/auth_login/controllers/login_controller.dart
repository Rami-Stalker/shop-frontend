import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/src/models/user_model.dart';
import '../../../resources/local/user_local.dart';
import '../repositories/login_repository.dart';

import '../../../public/components.dart';

import '../../../core/api/api_client.dart';
import '../../../controller/user_controller.dart';
import '../../../public/constants.dart';
import '../../../dependencies.dart' as dep;
import '../../../routes/app_pages.dart';
import '../../../services/firebase_messaging/push_notification_service.dart';

class LoginController extends GetxController implements GetxService {
  final ApiClient apiClient;
  final LoginRepository loginRepository;
  SharedPreferences sharedPreferences;
  LoginController({
    required this.apiClient,
    required this.loginRepository,
    required this.sharedPreferences,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
  }

  void signInUser(
    String email,
    String password,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await loginRepository.login(email, password);

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () async {
          await dep.init();
          PushNotificationService().getToken();
          // loginRepository.saveUserToken(jsonDecode(res.body)['token']);
          UserLocal().saveAccessToken(jsonDecode(res.body)['token']);
          loginRepository.saveUserType(jsonDecode(res.body)['type']);
          Get.find<UserController>().setUserFromJson(res.body);
          emailC.text = '';
          passwordC.text = '';
          if (Get.find<UserController>().user.type == 'user') {
            Get.put(UserController());
            Get.offNamedUntil(Routes.USER_NAVIGATION, (route) => false);
          } else {
            Get.put(UserController());
            Get.offNamedUntil(Routes.ADMIN_NAVIGATOR, (route) => false);
          }
        },
      );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void getInfoUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response tokenRes = await loginRepository.tokenIsValid();
      bool response = jsonDecode(tokenRes.body);

      if (response == true) {
        UserModel? user = await loginRepository.getInfoUser();

        UserLocal().saveUser(user!);
        Get.find<UserController>().setUserFromModel(user);
        
      }
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void saveUserTokenFCM(String tokenFCM) async {
    try {
      http.Response res = await loginRepository.saveUserTokenFCM(tokenFCM);
      Constants.httpErrorHandle(res: res, onSuccess: () {});
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  String getUserToken() {
    return sharedPreferences.getString('token-key') ?? '';
  }

  String getUserType() {
    return sharedPreferences.getString('type-key') ?? '';
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey('token-key');
  }

  bool clearSharedData() {
    sharedPreferences.remove('token-key');
    apiClient.tokenKey = '';
    apiClient.updateHeaders('');
    return true;
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
