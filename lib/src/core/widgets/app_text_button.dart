import 'package:flutter/material.dart';
import 'package:shop_app/src/themes/font_family.dart';
import '../../themes/app_colors.dart';
import '../../utils/sizer_custom/sizer.dart';

class AppTextButton extends StatelessWidget {
  final String txt;
  final Function() onTap;
  final Color backgroundColor;
  const AppTextButton({
    Key? key,
    required this.txt,
    required this.onTap,
    this.backgroundColor =const Color(0xFF89DAD0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.sp,
            ),
          ),
          padding: EdgeInsets.all(10.sp)),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 18.sp,
          color: mCL,
          fontFamily: FontFamily.lato,
        ),
      ),
    );
  }
}
