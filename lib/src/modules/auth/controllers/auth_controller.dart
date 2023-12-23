import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:quiver/async.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/resources/remote/user_repository.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import '../../../core/picker/picker.dart';
import '../../../models/upload_response_model.dart';
import '../../../resources/local/user_local.dart';
import '../../../resources/remote/upload_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/firebase_messaging/handle_messaging.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../repositories/auth_repository.dart';

import '../../../public/components.dart';

import '../../../public/constants.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;
  AuthController(this.authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late TextEditingController phoneLC;
  late TextEditingController passwordLC;

  late TextEditingController emailRC;
  late TextEditingController passwordRC;
  late TextEditingController nameRC;
  late TextEditingController phoneRC;
  late TextEditingController codeOtpRC;

  @override
  void onInit() {
    phoneLC = TextEditingController();
    passwordLC = TextEditingController();

    emailRC = TextEditingController();
    passwordRC = TextEditingController();
    nameRC = TextEditingController();
    phoneRC = TextEditingController();
    codeOtpRC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phoneLC.dispose();
    passwordLC.dispose();

    emailRC.dispose();
    passwordRC.dispose();
    nameRC.dispose();
    phoneRC.dispose();
    codeOtpRC.dispose();
    super.dispose();
  }

  UserModel? userModel;

  File? photoFile;
  void selectImageFromCamera() async {
    File? image = await pickImageFromCamera();
    if (image != null) {
      photoFile = image;
    }
    AppNavigator.pop();
    update();
  }

  void selectImageFromGallery() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      photoFile = image;
    }
    AppNavigator.pop();
    update();
  }

  Country? countryCode;
  void pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      useSafeArea: true,
      countryListTheme: CountryListThemeData(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomSheetHeight: SizerUtil.height - 300,
        textStyle: Theme.of(context).textTheme.titleLarge,
      ),
      onSelect: (Country _country) {
        countryCode = _country;
        update();
      },
    );
  }

  int _start = 28;
  int current = 10;
  bool isOnData = false;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      current = _start - duration.elapsed.inSeconds;
      isOnData = true;
      update();
    });

    sub.onDone(() {
      print("Done");
      current = 28;
      isOnData = false;
      sub.cancel();
    });
    update();
  }

  void sendCode() {
    String phoneNumber = phoneRC.text.trim();

    if (!isOnData) {
      if (phoneNumber.isNotEmpty) {
        startTimer();
        sendOtP(
          phoneCode: countryCode!.phoneCode,
          phoneNumber: '${phoneRC.text.trim()}',
        );
      } else {
        Components.showSnackBar(
          'Type your number until sent to you code OTP',
          title: 'Code OTP',
        );
      }
    }
  }

  void sendOtP({
    required String phoneCode,
    required String phoneNumber,
  }) async {
    try {
      diox.Response response =
          await authRepository.sendOtP(phoneCode, phoneNumber);
      AppConstants.handleApi(
        response: response,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "OTP");
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
        photoCloud = await Components.cloudinaryPublic(photo.path);
      }

      String? fcmToken = await getFirebaseMessagingToken();

      diox.Response response = await authRepository.register(
        photo: photoCloud,
        name: name,
        email: email,
        password: password,
        phone: phoneNumber,
        fcmToken: fcmToken ?? "",
      );

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          userModel = UserModel.fromMap(response.data as Map<String, dynamic>);
          AppNavigator.replaceWith(AppRoutes.LOGIN);
          Components.showSnackBar(
            'Signed up successfully login now',
            color: colorPrimary,
            title: 'Signed up',
          );
          update();
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      Components.showSnackBar(e.toString(), title: "Register");
    }
  }

  void login(String phone, String password) async {
    try {
      _isLoading = true;
      update();
      diox.Response response = await authRepository.login(
        phone,
        password,
      );

      AppConstants.handleApi(
        response: response,
        onSuccess: () async {
          await AppGet.init();
          userModel = UserModel.fromMap(response.data as Map<String, dynamic>);
          UserLocal().saveUserId(response.data['_id']);
          UserLocal().saveAccessToken(response.data['token']);
          UserLocal().saveUserType(response.data['type']);
          AppNavigator.replaceWith(AppRoutes.NAVIGATION);
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

      AppConstants.handleApi(
        response: tokenResponse,
        onSuccess: () async {
          bool isTokenValid = tokenResponse.data;
          if (isTokenValid) {
            diox.Response response = await authRepository.getInfoUser();
            AppConstants.handleApi(
              response: response,
              onSuccess: () {
                UserModel user =
                    UserModel.fromMap(response.data as Map<String, dynamic>);
                userModel = user;
                UserLocal().saveUser(user);
                update();
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
          update();
        }
      }
      AppNavigator.popUntil(AppRoutes.NAVIGATION);
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
      userModel = UserModel(
        id: "",
        photo: "",
        blurHash: "",
        name: "",
        email: "",
        phone: "",
        password: "",
        address: "",
        type: "",
        tokenFCM: "",
        token: "",
      );
      AppNavigator.popUntil(AppRoutes.NAVIGATION);
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    await UserRepository().deleteAccount();
    AppNavigator.popUntil(AppRoutes.NAVIGATION);
    logOut();
  }

  void saveUserTokenFCM(String tokenFCM) async {
    try {
      diox.Response res = await authRepository.saveUserTokenFCM(tokenFCM);
      AppConstants.handleApi(
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
