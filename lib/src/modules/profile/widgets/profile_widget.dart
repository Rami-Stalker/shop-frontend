import 'package:flutter/material.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/public/components.dart';

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
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Components.customContainer(
          context,
          Row(
            children: [
              appIcon,
              SizedBox(width: 15.sp),
              Expanded(
                child: AppText(
                  text,
                  maxLines: 2,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 12.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
