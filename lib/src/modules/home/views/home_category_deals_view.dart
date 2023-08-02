import 'package:shop_app/src/modules/home/controllers/home_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/no_data_page.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/icon_text_widget.dart';
import '../../../core/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';

class HomeCategoryDealsView extends GetView<HomeController> {
  const HomeCategoryDealsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.productCategory = [];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: BigText(
          text: Get.arguments,
          color: Colors.white,
        ),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: AppIcon(
            onTap: () => Get.back(),
            icon: Icons.arrow_back_ios,
            backgroundColor: AppColors.originColor,
          ),
        ),
      ),
      body: //list of food and images
          Column(
        children: [
          FutureBuilder<List<ProductModel>?>(
              future: controller.fetchCategoryProduct(category: Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.productCategory?.length ?? 0,
                        itemBuilder: (context, index) {
                          var product = controller.productCategory![index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 10.sp,
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(
                                  Routes.PRODUCT_DETAILS_RATING,
                                  arguments: {
                                    'product': product,
                                    'ratings': product.rating,
                                  },
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 10.sp,
                                    right: 10.sp,
                                    bottom: 5.sp,
                                  ),
                                  child: Row(
                                    children: [
                                      //image section
                                      Container(
                                        width: Dimensions.listViewImgSize,
                                        height: Dimensions.listViewImgSize,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15.sp,
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
                                          height:
                                              Dimensions.listViewTextConSize,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                15.sp,
                                              ),
                                              bottomRight: Radius.circular(
                                                15.sp,
                                              ),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 5.sp,
                                              right: 5.sp,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BigText(
                                                  text: product.name,
                                                ),
                                                SizedBox(
                                                  height: 5.sp,
                                                ),
                                                SmallText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxline: 1,
                                                  text: product.description,
                                                ),
                                                SizedBox(
                                                  height: 5.sp,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconAndTextWidget(
                                                      icon: Icons.circle_sharp,
                                                      text: 'Normal',
                                                      iconColor:
                                                          AppColors.iconColor1,
                                                    ),
                                                    IconAndTextWidget(
                                                      icon: Icons.location_on,
                                                      text: '1.7KM',
                                                      iconColor:
                                                          AppColors.mainColor,
                                                    ),
                                                    IconAndTextWidget(
                                                      icon: Icons
                                                          .access_time_rounded,
                                                      text: '23min',
                                                      iconColor:
                                                          AppColors.iconColor2,
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
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Expanded(
                    child: NoDataPage(
                      text: "Your cart history is empty",
                      imgPath: Constants.EMPTY_ASSET,
                    ),
                  );
                }
                return const Expanded(child: CustomLoader());
              }),
        ],
      ),
    );
  }
}
