import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../utils/sizer_custom/sizer.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80.sp,
        width: 80.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorPrimary,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: mCL),
      ),
    );
  }
}