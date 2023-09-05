import 'package:flutter/material.dart';
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
          decoration: AppDecoration.dots(context, 10.sp).decoration,
          child: ListTile(
            leading: SizedBox(
              width: 30.sp,
              child: Image.asset(
                widget.image,
                height: 45.sp,
              ),
            ),
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            trailing: widget.radio,
          ),
        ),
        SizedBox(height: 10.sp),
      ],
    );
  }
}
