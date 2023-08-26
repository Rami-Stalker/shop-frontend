import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/local/user_local.dart';
import '../repositories/register_repository.dart';
import '../../../themes/app_colors.dart';

import '../../../public/components.dart';

import '../../../core/api/api_client.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController implements GetxService {
  final ApiClient apiClient;
  final RegisterRepository registerRepository;
  SharedPreferences sharedPreferences;
  RegisterController({
    required this.apiClient,
    required this.registerRepository,
    required this.sharedPreferences,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController emailUC = TextEditingController();
  TextEditingController passwordUC = TextEditingController();
  TextEditingController nameUC = TextEditingController();
  TextEditingController phoneUC = TextEditingController();
  TextEditingController codeOtpUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailUC.dispose();
    passwordUC.dispose();
    nameUC.dispose();
    phoneUC.dispose();
    codeOtpUC.dispose();
  }

  void sendOtP({
    required String phoneCode,
    required String phoneNumber,
  }) async {
    try {
      await registerRepository.sendOtP(phoneCode, phoneNumber);
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void signUpUser({
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

      http.Response verifyRes =
          await registerRepository.verifyOTP(phoneCode, phoneNumber, codeOTP);

      Constants.httpErrorHandle(
          res: verifyRes,
          onSuccess: () async {
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

            http.Response res = await registerRepository.signUpUser(
              photo: photoCloud,
              name: name,
              email: email,
              password: password,
              phone: phoneNumber,
            );

            Constants.httpErrorHandle(
              res: res,
              onSuccess: () {
                UserLocal().saveAccessToken(jsonDecode(res.body)['token']);
                Components.showSnackBar(
                  title: 'Sign Up',
                  "Account created! Login with the same credentials!",
                  color: colorPrimary,
                );
                emailUC.text = '';
                passwordUC.text = '';
                nameUC.text = '';
                phoneUC.text = '';
                Get.toNamed(Routes.LOGIN);
              },
            );
          });
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
