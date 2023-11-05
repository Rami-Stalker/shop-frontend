import 'package:get/get.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../../../public/components.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class ProductSearchWidget extends GetView<SearchController> {
  final ProductModel product;
  const ProductSearchWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;
    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }
    return GestureDetector(
      onTap: () {
        if (AppGet.authGet.userModel!.type == 'admin') {
          AppNavigator.push(
            AppRoutes.EDIT_PRODUCT,
            arguments: {
              'product': product,
              'ratings': product.ratings,
            },
          );
        } else {
          AppNavigator.push(
            AppRoutes.DETAILS_PRODUCT_RATING,
            arguments: {
              'product': product,
              'ratings': product.ratings,
            },
          );
        }
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              width: 80.sp,
              height: 80.sp,
              decoration: BoxDecoration(
                color: mCL,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    product.images[0],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppText(
                    product.name,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText('\$ ${product.price.toString()}'),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    'Eligible for FREE Shipping',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            avgRating != 0.0
                ? Padding(
                    padding: EdgeInsets.only(
                      right: 5.sp,
                      top: 5.sp,
                    ),
                    child: Components.customRating(
                      avgRating.toString(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
