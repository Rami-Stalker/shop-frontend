import 'package:flutter/material.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.sp,
        width: 100.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.sp),
          color: colorPrimary,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}