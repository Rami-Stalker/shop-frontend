import 'package:shop_app/app/modules/home/controllers/home_controller.dart';

import '../../../core/utils/app_strings.dart';
import '../../../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/small_text.dart';
import '../../../routes/app_pages.dart';
import '../widgets/food_body.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void navigateToSearchView() {
    Get.toNamed(Routes.SEARCH);
  }

  Future<void> _loadResources() async {
    await Get.find<HomeController>().fetchAllProduct();
    await Get.find<HomeController>().fetchRatingProduct();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
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
          child: GetBuilder<UserController>(
            builder: (userController) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                userController.user.address.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.APP_NAME,
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SmallText(
                            text: userController.user.address.length > 30
                                ? '${userController.user.address.substring(0, 30)}...'
                                : '',
                            color: Colors.black54,
                          ),
                        ],
                      )
                    : Text(
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
        ),
        GetBuilder<HomeController>(builder: (homeController) {
          return homeController.productRating.isNotEmpty
              ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _loadResources();
                    },
                    child: const SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: FoodBody(),
                    ),
                  ),
                )
              : const Expanded(child: CustomLoader());
        }),
      ],
    );
  }
}
