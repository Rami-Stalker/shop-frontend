import 'package:i18n_extension/i18n_widget.dart';
import 'modules/auth_login/controllers/login_controller.dart';
import 'utils/sizer_custom/sizer.dart';

import 'config/language.dart';
import 'routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'themes/theme_service.dart';
import 'themes/themes.dart';

class App extends StatefulWidget {
  App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // Get.find<ApplicationController>().onSetupApplication();
  }

  String initRoute() {
    if (Get.find<LoginController>().getUserType() == "admin") {
      return Routes.ADMIN_NAVIGATOR;
    } else {
      return Routes.USER_NAVIGATION;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return I18n(
          child: GetMaterialApp(
            // onInit: () async {
            //   await dep.init();
            // },
            debugShowCheckedModeBanner: false,
            locale: AppLanguage.defaultLanguage,
            supportedLocales: AppLanguage.supportLanguage,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.light().data,
            darkTheme: AppTheme.dark().data,
            themeMode: ThemeService().getThemeMode(),
            initialRoute: initRoute(),
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
