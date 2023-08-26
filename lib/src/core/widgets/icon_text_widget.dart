import 'package:flutter/material.dart';

import 'small_text.dart';
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
          size: Dimensions.iconSize24,
        ),
        SizedBox(
          width: 3.sp,
        ),
        SmallText(text: text),
      ],
    );
  }
}
