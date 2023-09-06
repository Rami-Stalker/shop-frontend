import 'package:flutter/material.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../../../themes/app_decorations.dart';

import '../../../utils/sizer_custom/sizer.dart';

class AccountWidget extends StatelessWidget {
  final Widget appIcon;
  final String text;
  final Function() onTap;
  const AccountWidget({
    Key? key,
    required this.appIcon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(
          5.sp,
        ),
        padding: EdgeInsets.all(
          5.sp,
        ),
        decoration: AppDecoration.textfeild(context, 5.sp).decoration,
        child: Row(
          children: [
            appIcon,
            SizedBox(width: 15.sp),
            Expanded(
              child: AppText(
                text,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
