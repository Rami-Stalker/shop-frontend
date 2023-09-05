import 'package:flutter/material.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../core/widgets/icon_text_widget.dart';

class ProductDetailsHome extends StatelessWidget {
  final String name;
  final String category;
  final int price;
  final int oldPrice;
  const ProductDetailsHome({
    Key? key,
    required this.name,
    required this.category,
    required this.price,
    required this.oldPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Text(
              '\$${price.toString()}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(width: 5.sp),
            oldPrice != 0
                ? Text(
                    '\$${oldPrice.toString()}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.sp,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                : Container(),
            const Spacer(),
            Container(
              padding: EdgeInsets.all(
                5.sp,
              ),
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.category,
                    color: colorBlack,
                    size: 15.sp,
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      color: colorBlack,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: colorMedium,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: '1.7KM',
              iconColor: colorPrimary,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: '23min',
              iconColor: colorHigh,
            ),
          ],
        ),
      ],
    );
  }
}
