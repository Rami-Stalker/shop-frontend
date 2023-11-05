import 'package:flutter/material.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../core/widgets/icon_text_widget.dart';

class ProductDetailsHome extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsHome({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(product.name),
        SizedBox(height: 5.sp),
        Row(
          children: [
            Text(
              '\$${product.price.toString()}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: colorPrimary,
                  ),
            ),
            SizedBox(width: 5.sp),
            product.oldPrice != 0
                ? Text(
                    '\$${product.oldPrice.toString()}',
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
                    product.category,
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
              iconColor: colorBranch,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: '1.7KM',
              iconColor: colorPrimary,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: '${product.time}min',
              iconColor: Colors.redAccent,
            ),
          ],
        ),
      ],
    );
  }
}
