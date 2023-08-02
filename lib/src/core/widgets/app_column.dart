import 'package:flutter/material.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../utils/app_colors.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String name;
  final String category;
  final int price;
  final int oldPrice;
  const AppColumn({
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
        BigText(
          text: name,
          size: 20.sp,
          overflow: TextOverflow.clip,
        ),
        SizedBox(
          height: 5.sp,
        ),
        Row(
          children: [
            BigText(
              text: '\$${price.toString()}',
              color: Colors.black,
              size: 15.sp,
            ),
            SizedBox(
              width: 5.sp,
            ),
            oldPrice != 0 ? Text(
              '\$${oldPrice.toString()}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                decoration: TextDecoration.lineThrough,
              ),
            ) : Container(),
            const Spacer(),
            Container(
                padding: EdgeInsets.all(
                  5.sp,
                ),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.category,
                      color: Colors.black,
                      size: 15.sp,
                    ),
                    Text(
                      category,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
            ),
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: '1.7KM',
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: '23min',
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
