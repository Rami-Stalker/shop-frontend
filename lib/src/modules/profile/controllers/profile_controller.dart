import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/upload_response_model.dart';
import '../../../models/user_model.dart';
import '../../../resources/local/user_local.dart';
import '../../../resources/remote/upload_repository.dart';
import '../../../resources/remote/user_repository.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final SharedPreferences sharedPreferences;
  ProfileController({
    required this.sharedPreferences,
  });

  Future<void> updateAvatar({
    required File avatar,
  }) async {
    UploadResponseModel? response = await UploadRepository().uploadSingleFile(file: avatar);

    if (response != null) {
      UserModel? user = await UserRepository().updateAvatar(
        avatar: response.image,
        blurHash: response.blurHash,
      );
      if (user != null) {
        UserLocal().saveUser(user);
      }
    }
    // Get.toNamed(Routes.ROOT);
  }
  
  void logOut() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Get.offNamedUntil(Routes.LOGIN, (route) => false);
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }
}
