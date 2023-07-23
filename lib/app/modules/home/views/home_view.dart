import 'package:shop_app/app/controller/notification_controller.dart';
import 'package:shop_app/app/models/notification_model.dart';
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
    await Get.find<HomeController>().fetchNewestProduct();
    await Get.find<HomeController>().fetchRatingProduct();
    await Get.find<NotificationController>().getNotofication();
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
                FutureBuilder<List<NotificationModel>>(
                    future:
                        Get.find<NotificationController>().getNotofication(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int isSeen = 0;
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          if (snapshot.data![i].isSeen == false) {
                            isSeen += 1;
                          }
                        }
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.NOTIFICATION,
                                arguments: snapshot.data);
                          },
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.height10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius15 - 8),
                            ),
                            child: Stack(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  size: Dimensions.iconSize24,
                                  color: AppColors.mainColor,
                                ),
                                isSeen != 0
                                    ? Positioned(
                                        top: 0.0,
                                        right: 0.0,
                                        child: CircleAvatar(
                                          radius: Dimensions.radius15 - 8,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: Dimensions.radius15 - 9,
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container(
                        padding: EdgeInsets.all(Dimensions.height10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15 - 8),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: Dimensions.iconSize24,
                          color: AppColors.mainColor,
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          child: InkWell(
            onTap: navigateToSearchView,
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(Dimensions.height15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ],
                borderRadius: BorderRadius.circular(Dimensions.radius15 - 8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search your desired food",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: Dimensions.iconSize24,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.height15),
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
