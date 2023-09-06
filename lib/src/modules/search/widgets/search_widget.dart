import 'package:get/get.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../../../public/components.dart';
import '../controllers/search_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../routes/app_pages.dart';

class SearchWidget extends GetView<SearchController> {
  final ProductModel product;
  const SearchWidget({
    Key? key,
    required this.product,
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
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GetBuilder<SearchControlle>(
          builder: (cont) => GestureDetector(
                onTap: () {
                  if (AppGet.authGet.userModel!.type == 'admin') {
                    AppNavigator.push(
                      Routes.PRODUCT_EDIT,
                      arguments: {
                        'product': product,
                        'ratings': product.rating,
                      },
                    );
                  } else {
                    AppNavigator.push(
                      Routes.PRODUCT_DETAILS_RATING,
                      arguments: {
                        'product': product,
                        'ratings': product.rating,
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
              )),
    );
  }
}
