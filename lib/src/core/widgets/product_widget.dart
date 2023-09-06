import 'package:flutter/material.dart';
import 'package:shop_app/src/public/components.dart';

import '../../models/product_model.dart';
import '../../utils/sizer_custom/sizer.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_decorations.dart';
import 'app_text.dart';
import 'icon_text_widget.dart';

class ProductWidget extends StatelessWidget {
  final VoidCallback onTap;
  final ProductModel product;
  final int index;
  const ProductWidget({
    Key? key,
    required this.onTap,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.sp,
          vertical: 5.sp,
        ),
        child: Row(
          children: [
            Container(
              width: 100.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15.sp,
                ),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    product.images[0],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.sp),
                decoration: AppDecoration.product(
                  context,
                  15.sp,
                ).decoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText(product.name),
                        Spacer(),
                        avgRating != 0.0
                            ? Components.customRating(avgRating.toString())
                            : Container(),
                      ],
                    ),
                    Text(
                      product.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 5.sp),
                    Row(
                      children: [
                        IconAndTextWidget(
                          icon: Icons.location_on,
                          text: '1.7KM',
                          iconColor: colorPrimary,
                        ),
                        SizedBox(width: 10.sp),
                        IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: '23min',
                          iconColor: colorHigh,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
