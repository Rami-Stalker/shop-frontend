import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ThemeOptions { light, dark }

class ThemeService {
  static ThemeOptions themeOptions = ThemeOptions.light;
  static ThemeMode currentTheme = ThemeMode.light;
  static final systemBrightness = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  );
  // final _getStorage = GetStorage();
  // final storageKey = 'isDarkMode';


  // switchStatusColor() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarBrightness: Platform.isIOS
  //         ? (isSavedDarkMode() ? Brightness.dark : Brightness.light)
  //         : (isSavedDarkMode() ? Brightness.light : Brightness.dark),
  //     statusBarIconBrightness: Platform.isIOS
  //         ? (isSavedDarkMode() ? Brightness.dark : Brightness.light)
  //         : (isSavedDarkMode() ? Brightness.light : Brightness.dark),
  //   ));
  // }

  // ThemeMode getThemeMode() {
  //   switchStatusColor();
  //   return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  // }

  // bool isSavedDarkMode() {
  //   return _getStorage.read(storageKey) ?? false;
  // }

  // void saveThemeMode(bool isDarkMode) async {
  //   _getStorage.write(storageKey, isDarkMode);
  // }

  // void changeThemeMode() {
  //   saveThemeMode(!isSavedDarkMode());
  //   switchStatusColor();
  // }

  final GetStorage _box = GetStorage();
  final _key = 'mode-theme';

  void _writeBox(bool istheme) => _box.write(_key, istheme);

  bool _readBox() => _box.read<bool>(_key) ?? false;

  ThemeMode get theme => _readBox() ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    Get.changeThemeMode(_readBox() ? ThemeMode.light : ThemeMode.dark);
    _writeBox(!_readBox());
  }
}

ThemeService themeService = ThemeService();