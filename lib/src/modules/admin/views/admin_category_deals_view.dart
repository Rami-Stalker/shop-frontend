import 'package:shop_app/src/modules/admin/controllers/admin_controller.dart';
import 'package:shop_app/src/modules/home/controllers/home_controller.dart';
import 'package:shop_app/src/public/constants.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/no_data_page.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/icon_text_widget.dart';
import '../../../core/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/sizer_custom/sizer.dart';

class AdminCategoryDealsView extends GetView<AdminController> {
  const AdminCategoryDealsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.productCategory = [];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: //list of food and images
          Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: 100.sp,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              left: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back_ios,
                  backgroundColor: AppColors.originColor,
                ),
                BigText(
                  text: Get.arguments,
                  color: Colors.white,
                ),
                Container(
                  width: Dimensions.height45,
                ),
              ],
            ),
          ),
          GetBuilder<HomeController>(builder: (homeCtrl) {
            return controller.productCategory!.isNotEmpty
                ? controller.isLoading != true
                    ? MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.productCategory?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    var product =
                                        controller.productCategory![index];
                                    double totalRating = 0;
                                    double avgRating = 0;
                                    for (int i = 0;
                                        i < product.rating!.length;
                                        i++) {
                                      totalRating += product.rating![i].rating;
                                    }
                                    if (totalRating != 0) {
                                      avgRating =
                                          totalRating / product.rating!.length;
                                    }
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        GestureDetector(
                                          onTap: () => Get.toNamed(
                                            Routes.EDIT_PRODUCT,
                                            arguments: {
                                              'product':
                                                  product,
                                              'ratings':
                                                  product.rating,
                                            },
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: Dimensions.width20,
                                              right: Dimensions.width20,
                                              bottom: Dimensions.height10,
                                            ),
                                            child: Row(
                                              children: [
                                                //image section
                                                Container(
                                                  width: Dimensions
                                                      .listViewImgSize,
                                                  height: Dimensions
                                                      .listViewImgSize,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.radius20,
                                                    ),
                                                    color: Colors.white38,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        product.images[0],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                //text container
                                                Expanded(
                                                  child: Container(
                                                    height: Dimensions
                                                        .listViewTextConSize,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                          Dimensions.radius20,
                                                        ),
                                                        bottomRight:
                                                            Radius.circular(
                                                          Dimensions.radius20,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              BigText(
                                                                text: product
                                                                    .name,
                                                              ),
                                                              avgRating != 0.0
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                          Dimensions
                                                                              .width10,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.starColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(Dimensions.radius15),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 1,
                                                                              offset: const Offset(0, 2),
                                                                              color: Colors.grey.withOpacity(0.2),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: Colors.black,
                                                                              size: 20,
                                                                            ),
                                                                            Text(
                                                                              avgRating.toString(),
                                                                              style: const TextStyle(
                                                                                color: Colors.black,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height10,
                                                          ),
                                                          SmallText(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxline: 1,
                                                            text: product
                                                                .description,
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              IconAndTextWidget(
                                                                icon: Icons
                                                                    .circle_sharp,
                                                                text: 'Normal',
                                                                iconColor: AppColors
                                                                    .iconColor1,
                                                              ),
                                                              IconAndTextWidget(
                                                                icon: Icons
                                                                    .location_on,
                                                                text: '1.7KM',
                                                                iconColor:
                                                                    AppColors
                                                                        .mainColor,
                                                              ),
                                                              IconAndTextWidget(
                                                                icon: Icons
                                                                    .access_time_rounded,
                                                                text: '23min',
                                                                iconColor: AppColors
                                                                    .iconColor2,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      )
                    : const Expanded(child: CustomLoader())
                : const Expanded(
                    child: NoDataPage(
                      text: "That's Category is Empty",
                      imgPath: Constants.EMPTY_ASSET,
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
