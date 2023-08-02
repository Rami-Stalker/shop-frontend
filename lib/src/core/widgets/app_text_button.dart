import 'package:flutter/material.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../utils/app_colors.dart';

class AppTextButton extends StatelessWidget {
  final String txt;
  final Function() onTap;
  const AppTextButton({
    Key? key,
    required this.txt,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.sp,
            ),
          ),
          padding: EdgeInsets.all(Dimensions.height10)),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: Dimensions.font20,
          color: Colors.white,
        ),
      ),
    );
  }
}
