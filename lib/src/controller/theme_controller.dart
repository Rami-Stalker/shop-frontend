import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/theme_service.dart';

class ThemeController extends GetxController {
  void initialTheme(ThemeMode? themeMode) {
    ThemeService.currentTheme = themeMode ?? ThemeService.currentTheme;
    ThemeService().switchStatusColor();
  }

  void onChangeTheme(ThemeMode? themeMode) {
    ThemeService.currentTheme = themeMode ?? ThemeService.currentTheme;
    ThemeService().changeThemeMode();
  }
}
