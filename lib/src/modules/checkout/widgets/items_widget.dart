import 'package:flutter/material.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';

import '../../../utils/sizer_custom/sizer.dart';

class ItemsWidget extends StatelessWidget {
  final String txt;
  final String account;
  const ItemsWidget({
    Key? key,
    required this.txt,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.sp,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt,
                type: TextType.medium,
              ),
              AppText(
                account,
                type: TextType.small,
              ),
            ],
          ),
          SizedBox(height: 8.sp),
        ],
      ),
    );
  }
}
