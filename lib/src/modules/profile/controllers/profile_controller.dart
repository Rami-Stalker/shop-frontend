import 'dart:io';

import 'package:get/get.dart';

import '../../../models/upload_response_model.dart';
import '../../../models/user_model.dart';
import '../../../resources/local/user_local.dart';
import '../../../resources/remote/upload_repository.dart';
import '../../../resources/remote/user_repository.dart';

class ProfileController extends GetxController {
  ProfileController();

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
  }
}
