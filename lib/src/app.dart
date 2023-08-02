import 'package:i18n_extension/i18n_widget.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/src/modules/auth/repositories/auth_repository.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import 'config/language.dart';
import 'routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'themes/theme_service.dart';
import 'themes/themes.dart';

class App extends StatelessWidget {
  App({
    Key? key,
  }) : super(key: key);

  String initRoute() {
    if (Get.find<AuthRepository>().getUserType() == "admin") {
      return Routes.ADMIN_NAVIGATOR;
    } else {
      return Routes.USER_NAVIGATOR;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthRepository>().userLoggedIn()) {
      Get.find<AuthController>().getUserData();
    }
    return Sizer(
      builder: (context, orientation, deviceType) {
        return I18n(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ramy app',
            locale: AppLanguage.defaultLanguage,
            supportedLocales: AppLanguage.supportLanguage,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.light().data,
            darkTheme: AppTheme.dark().data,
            themeMode: ThemeService.currentTheme,
            initialRoute: initRoute(),
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
