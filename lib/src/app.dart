import 'package:i18n_extension/i18n_widget.dart';
import 'package:shop_app/src/lang/language_service.dart';
import 'package:shop_app/src/public/constants.dart';
import 'controller/app_controller.dart';
import 'lang/localization.dart';
import 'routes/app_pages.dart';
import 'utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'themes/theme_service.dart';
import 'themes/themes.dart';

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  MyApp({required this.languages});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return I18n(
          child: GetBuilder<LocalizationController>(
              builder: (localizationController) {
            return GetMaterialApp(
              onDispose: () {
                AppGet.dispose();
              },
              debugShowCheckedModeBanner: false,
              // supportedLocales: AppLanguage.supportLanguage,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: localizationController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(
                AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode,
              ),
              themeMode: ThemeService().theme,
              theme: AppTheme.light().data,
              darkTheme: AppTheme.dark().data,
              initialRoute: AppRoutes.SPLASH,
              unknownRoute: AppNavigator.routes[1],
              getPages: AppNavigator.routes,
            );
          }),
        );
      },
    );
  }
}
