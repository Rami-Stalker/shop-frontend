import 'package:flutter/material.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../../../themes/app_decorations.dart';

import '../../../utils/sizer_custom/sizer.dart';


class RadioWidget extends StatefulWidget {
  final String image;
  final String title;
  final Radio radio;
  const RadioWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.radio,
  }) : super(key: key);

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppDecoration.productFavoriteCart(context, 6.sp).decoration,
          child: ListTile(
            leading: widget.radio,
            title: AppText(
              widget.title,
            ),
          ),
        ),
        SizedBox(height: 10.sp),
      ],
    );
  }
}
