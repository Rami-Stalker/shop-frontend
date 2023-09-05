import 'package:flutter/material.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.sp,
        width: 100.sp,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100.sp,
                    width: 100.sp,
                    child: Constants().splashLottie,
                  ),
                  SizedBox(height: 16.sp),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Ramy',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          // fontFamily: FontFamily.dancing,
                          color: colorPrimary,
                        ),
                      ),
                      TextSpan(
                        text: 'shop',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          // fontFamily: FontFamily.dancing,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ))
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