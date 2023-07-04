import 'package:shop_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/app/modules/cart/controllers/cart_controller.dart';

import '../../../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../routes/app_pages.dart';
import '../widgets/profile_widget.dart';

class ProfileView extends GetView<UserController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10 * 10,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              left: Dimensions.width20,
            ),
            child: Center(
              child: BigText(
                text: 'Profile',
                color: Colors.white,
              ),
            ),
          ),
          GetBuilder<AuthController>(
            builder: (userCtrl) => userLoggedIn
                ? (!userCtrl.isLoading
                    ? MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: Expanded(
                          child: ListView(
                            children: [
                              Container(
                                width: double.maxFinite,
                                margin:
                                    EdgeInsets.only(top: Dimensions.height20),
                                child: Column(
                                  children: [
                                    //profile icon
                                    AppIcon(
                                      onTap: () {},
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height45 +
                                          Dimensions.height30,
                                      size: Dimensions.height15 * 10,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //body
                                    Column(
                                      children: [
                                        //name
                                        AccountWidget(
                                          onTap: () {
                                            Get.put(UserController());
                                            Get.toNamed(Routes.UPDATE_PROFILE);
                                          },
                                          appIcon: AppIcon(
                                            onTap: () {},
                                            icon: Icons.person,
                                            backgroundColor:
                                                AppColors.mainColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: controller.user.name,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        //phone
                                        AccountWidget(
                                          onTap: () {
                                            Get.toNamed(Routes.UPDATE_PROFILE);
                                          },
                                          appIcon: AppIcon(
                                            onTap: () {},
                                            icon: Icons.phone,
                                            backgroundColor:
                                                AppColors.originColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: controller.user.phone,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        //email
                                        AccountWidget(
                                          onTap: () {},
                                          appIcon: AppIcon(
                                            onTap: () {},
                                            icon: Icons.email,
                                            backgroundColor:
                                                AppColors.originColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: controller.user.email,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        //address
                                        AccountWidget(
                                          onTap: () {
                                            Get.toNamed(Routes.UPDATE_PROFILE);
                                          },
                                          appIcon: AppIcon(
                                            onTap: () {},
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.originColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            overflow: TextOverflow.ellipsis,
                                            text: controller.user.address,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        //messages
                                        AccountWidget(
                                          onTap: () {},
                                          appIcon: AppIcon(
                                            onTap: () {},
                                            icon: Icons.message_outlined,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(text: 'Messages'),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        //sign out
                                        AccountWidget(
                                          onTap: () {
                                            if (Get.find<AuthController>().userLoggedIn()) {
                                              Get.find<AuthController>().clearSharedData();
                                              Get.find<CartController>().clear();
                                              Get.find<CartController>().clearCartHistory();
                                              Get.toNamed(Routes.SIGN_IN);
                                            }
                                          },
                                          appIcon: AppIcon(
                                            onTap: () {},
                                            icon: Icons.logout,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText:
                                              BigText(text: AppString.SIGN_OUT),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Expanded(
                        child: CustomLoader(),
                      ))
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 8,
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.height20),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AppString.ASSETS_EMPTY)),
                        ),
                      ),
                      SizedBox(height: Dimensions.height30),
                      GestureDetector(
                        onTap: () =>
                            Get.offNamedUntil(Routes.SIGN_IN, (route) => false),
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.height20),
                          ),
                          child: Center(
                              child: BigText(
                            text: AppString.SIGN_IN,
                            color: Colors.white,
                            size: Dimensions.font26,
                          )),
                        ),
                      ),
                    ],
                  )),
          ),
        ],
      ),
    );
  }
}
