import 'package:get/get.dart';
import 'package:shop_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:shop_app/app/modules/admin/widgets/admin_categories.dart';
import 'package:shop_app/app/routes/app_pages.dart';

import '../../../controller/user_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/icon_text_widget.dart';
import '../../../core/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ProductsView extends GetView<AdminController> {
  const ProductsView({Key? key}) : super(key: key);

  void navigateToAddProduct() {
    Get.toNamed(Routes.ADMIN_ADD_PRODUCT);
  }

  void navigateToSearchView() {
    Get.toNamed(Routes.SEARCH);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GetBuilder<AdminController>(builder: (adminC) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.height45,
                bottom: Dimensions.height15,
              ),
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.APP_NAME,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToSearchView,
                    child: Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const AdminCategories(),
            SizedBox(
              height: Dimensions.height15,
            ),
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: adminC.products.length,
                      itemBuilder: (context, index) {
                        var product = adminC.products[index];
                        double totalRating = 0;
                        double avgRating = 0;
                        for (int i = 0; i < product.rating!.length; i++) {
                          totalRating += product.rating![i].rating;
                        }
                        if (totalRating != 0) {
                          avgRating = totalRating / product.rating!.length;
                        }
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.EDIT_PRODUCT,
                              arguments: {
                                AppString.ARGUMENT_PRODUCT: product,
                                "index": index,
                              },
                            );
                          },
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
                                  width: Dimensions.listViewImgSize,
                                  height: Dimensions.listViewImgSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                          Dimensions.radius20,
                                        ),
                                        bottomRight: Radius.circular(
                                          Dimensions.radius20,
                                        ),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: Dimensions.width10,
                                        right: Dimensions.width10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: product.name,
                                              ),
                                              avgRating != 0.0
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          Dimensions.width10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.starColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              offset: const Offset(0, 2),
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
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
                                          avgRating == 0.0 ?
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ):Container(),
                                          SmallText(
                                            maxline: 1,
                                            color: Colors.grey[600],
                                            overflow: TextOverflow.ellipsis,
                                            text: product.description,
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
