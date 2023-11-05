import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/font_family.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Timer(
      Duration(seconds: 3),
      () => AppNavigator.replaceWith(AppRoutes.NAVIGATION),
    );
    // Future.delayed(Duration(seconds: 2), () {
    //   AppNavigator.replaceWith(AppRoutes.LANGUAGE);
    // });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorPrimary,
              colorBranch,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100.sp,
                    width: 100.sp,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Ramy',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.dancing,
                            color: colorPrimary,
                          ),
                        ),
                        TextSpan(
                          text: 'shop',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.dancing,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '@${DateTime.now().year}',
              style: TextStyle(
                fontSize: 7.sp,
                // fontFamily: FontFamily.lato,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.sp),
          ],
        ),
      ),
    );
  }
}

// class FlutterSplashScreen {
//   static const MethodChannel _channel =
//       const MethodChannel('flutter_splash_screen');

//   ///hide splash screen
//   static Future<Null> hide() async {
//     await _channel.invokeMethod('hide');
//   }
// }