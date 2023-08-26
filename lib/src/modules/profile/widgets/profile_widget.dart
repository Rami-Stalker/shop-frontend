import 'package:flutter/material.dart';
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
          Dimensions.width10,
        ),
        padding: EdgeInsets.all(
          Dimensions.width10,
        ),
        decoration: AppDecoration.textfeild(context, 5.sp).decoration,
        child: Row(
          children: [
            appIcon,
            SizedBox(width: Dimensions.width20),
            Expanded(
                child:
                    Text(text, style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 2)),
          ],
        ),
      ),
    );
  }
}
