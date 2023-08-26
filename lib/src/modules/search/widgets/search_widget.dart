import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../controller/user_controller.dart';
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
                  if (Get.find<UserController>().user.type == 'admin') {
                    Get.toNamed(
                      Routes.EDIT_PRODUCT,
                      arguments: {
                        'product': product,
                        'ratings': product.rating,
                      },
                    );
                  } else {
                    Get.toNamed(
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
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              product.name,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$ ${product.price.toString()}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),

                              ],
                            ),
                            SizedBox(height: Dimensions.height20),
                            Text(
                              'Eligible for FREE Shipping',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      avgRating != 0.0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: colorStar,
                                    size: 20,
                                  ),
                                  Text(
                                    avgRating.toString(),
                                  ),
                                ],
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
