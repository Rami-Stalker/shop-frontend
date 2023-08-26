import 'package:flutter/material.dart';

import '../utils/sizer_custom/sizer.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.appColors,
  });

  factory AppTheme.light() {
    final mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColors.background,
        elevation: 0.4,
        shape: RoundedRectangleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorMedium,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        elevation: 0.0,
      ),
      iconTheme: IconThemeData(
        color: appColors.header,
        size: 20.sp,
      ),
      textTheme: TextTheme(
        displayMedium: TextStyle(color: appColors.header),
        titleLarge: TextStyle(color: appColors.contentText1),
        titleMedium: TextStyle(color: appColors.contentText2),
        bodyLarge: TextStyle(color: appColors.contentText2),
      ),
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    final mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColors.background,
        elevation: 0.4,
        shape: RoundedRectangleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorMedium,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        elevation: 0.0,
      ),
      iconTheme: IconThemeData(
        color: appColors.header,
        size: 20.sp,
      ),
      textTheme: TextTheme(
        displayMedium: TextStyle(color: appColors.header),
        titleLarge: TextStyle(color: appColors.contentText1),
        titleMedium: TextStyle(color: appColors.contentText2),
        bodyLarge: TextStyle(color: appColors.contentText2),
      ),
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppColors appColors;
}
