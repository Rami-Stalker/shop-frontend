import 'package:flutter/material.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';

import '../../utils/sizer_custom/sizer.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24.sp,
        ),
        SizedBox(
          width: 3.sp,
        ),
        AppText(text, type: TextType.small),
      ],
    );
  }
}
