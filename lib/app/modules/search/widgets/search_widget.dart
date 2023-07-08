import 'package:get/get.dart';
import 'package:shop_app/app/modules/search/controllers/search_controller.dart';

import '../../../controller/user_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
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
                  if (Get.find<UserController>().user.type == 'user') {
                    Get.toNamed(
                      Routes.PRODUCT_DETAILS_RATING,
                      arguments: {
                        AppString.ARGUMENT_PRODUCT: product,
                        AppString.ARGUMENT_RATINGS: product.rating,
                      },
                    );
                  } else {
                    Get.toNamed(
                      Routes.EDIT_PRODUCT,
                      arguments: {
                        AppString.ARGUMENT_PRODUCT: product,
                        AppString.ARGUMENT_RATINGS: product.rating,
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
                        width: Dimensions.height20 * 5,
                        height: Dimensions.height20 * 5,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                            BigText(
                              text: product.name,
                              color: Colors.black54,
                              overflow: TextOverflow.clip,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(
                                  text: '\$ ${product.price.toString()}',
                                  color: Colors.redAccent,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10),
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            const Text(
                              'Eligible for FREE Shipping',
                              style: TextStyle(fontSize: 15),
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
                                    color: AppColors.starColor,
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
