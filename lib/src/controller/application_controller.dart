import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/controller/theme_controller.dart';

import '../config/application.dart';
import '../themes/theme_service.dart';

class ApplicationController extends GetxController {
  Stream onSetupApplication() async* {
    await Application().initialAppLication();
    Get.find<ThemeController>().initialTheme(
      ThemeService().isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
