import 'package:flutter/material.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/small_text.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

class ProductDetailsWidget extends StatelessWidget {
  final String name;
  final String category;
  final int price;
  final int oldPrice;
  const ProductDetailsWidget({
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
        BigText(text: name),
        // Text(
        //   name,
        //   overflow: TextOverflow.clip,
        //   maxLines: 1,
        //   style:
        //       Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20.sp),
        // ),
        SizedBox(
          height: 5.sp,
        ),
        Row(
          children: [
            BigText(text: '\$${price.toString()}'),
            SizedBox(
              width: 5.sp,
            ),
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
        SizedBox(
          height: 10.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconAndTextWidget(
              context: context,
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: colorMedium,
            ),
            _iconAndTextWidget(
              context: context,
              icon: Icons.location_on,
              text: '1.7KM',
              iconColor: colorPrimary,
            ),
            _iconAndTextWidget(
              context: context,
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

Row _iconAndTextWidget({
  required BuildContext context,
  required IconData icon,
  required String text,
  required Color iconColor,
}) {
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
