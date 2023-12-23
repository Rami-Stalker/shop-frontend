import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:shop_app/src/modules/settings/repositories/settings_repository.dart';
import 'package:shop_app/src/themes/app_colors.dart';

import '../../../core/picker/picker.dart';
import '../../../public/components.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import 'package:dio/dio.dart' as diox;

class SettingsCotnroller extends GetxController {
  final SettingsRepository settingsRepository;
  SettingsCotnroller(this.settingsRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  void updateAvatar({
    required File? photo,
  }) async {
    try {
      _isLoading = false;
      update();

      String photoCloud = '';

      if (photo != null) {
        photoCloud = await Components.cloudinaryPublic(photo.path);
      }

      diox.Response response = await settingsRepository.updateAvatar(
        photo: photoCloud,
        // toBlurHash : photo!.path,
      );

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          Components.showSnackBar(
            'Upload Image successfully',
            color: colorPrimary,
            title: 'Upload Image',
          );
          photoFile = null;
        },
      );

      _isLoading = false;
      update();
    } catch (e) {
      Components.showSnackBar(
        'Error when Upload Photo',
        title: 'Upload Photo',
      );
    }
  }
}
