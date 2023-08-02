import 'dart:io';

import 'package:shop_app/src/core/picker/picker.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/src/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/src/modules/navigator/controllers/navigator_user_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/components/app_components.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../widgets/profile_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserController userController = Get.find<UserController>();
  bool userLoggedIn = Get.find<AuthController>().userLoggedIn();

  File? image;

  void pickImageGallery() async {
    image = await pickImageFromGallery();
    Get.back();
    setState(() {});
  }

  void pickImageCamera() async {
    image = await pickImageFromCamera();
    Get.back();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: 100.sp,
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
                                    SizedBox(
                                      height: 170.sp,
                                      width: Dimensions.screenWidth,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 80.sp,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.mainColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: image != null
                                                    ? CircleAvatar(
                                                        radius: 80.sp,
                                                        backgroundImage:
                                                            FileImage(image!),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 80.sp,
                                                        backgroundColor:
                                                            AppColors.mainColor,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          userController
                                                              .user.photo,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              right: 0.0,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.bottomSheet(
                                                    SingleChildScrollView(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            Dimensions.radius15,
                                                          ),
                                                          color: Get.isDarkMode
                                                              ? Colors.black
                                                              : Colors.white,
                                                        ),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                          top: 4.sp,
                                                        ),
                                                        width: Dimensions
                                                            .screenWidth,
                                                        height: 150.sp,
                                                        child: Column(
                                                          children: [
                                                            Flexible(
                                                              child: Container(
                                                                height: 6.sp,
                                                                width: 120.sp,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    20,
                                                                  ),
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors.grey[
                                                                          600]
                                                                      : Colors.grey[
                                                                          300],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            AppComponents
                                                                .buildbottomsheet(
                                                              icon: Icon(
                                                                Icons.camera,
                                                                color: AppColors
                                                                    .mainColor,
                                                              ),
                                                              label:
                                                                  "From camera",
                                                              ontap:
                                                                  pickImageCamera,
                                                            ),
                                                            Divider(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                            AppComponents
                                                                .buildbottomsheet(
                                                              icon: Icon(
                                                                Icons.image,
                                                                color: AppColors
                                                                    .mainColor,
                                                              ),
                                                              label:
                                                                  "From Gallery",
                                                              ontap:
                                                                  pickImageGallery,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    elevation: 0.4,
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    size:
                                                        32.sp,
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //body
                                    AccountWidget(
                                      onTap: () {
                                        // Get.put(UserController());
                                        Get.toNamed(Routes.UPDATE_PROFILE);
                                      },
                                      appIcon: AppIcon(
                                        onTap: () {},
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: 25.sp,
                                        size: 50.sp,
                                      ),
                                      bigText: BigText(
                                        text: userController.user.name,
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
                                        backgroundColor: AppColors.originColor,
                                        iconColor: Colors.white,
                                        iconSize: 25.sp,
                                        size: 50.sp,
                                      ),
                                      bigText: BigText(
                                        text: userController.user.phone,
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
                                        backgroundColor: AppColors.originColor,
                                        iconColor: Colors.white,
                                        iconSize: 25.sp,
                                        size: 50.sp,
                                      ),
                                      bigText: BigText(
                                        text: userController.user.email,
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
                                        backgroundColor: AppColors.originColor,
                                        iconColor: Colors.white,
                                        iconSize: 25.sp,
                                        size: 50.sp,
                                      ),
                                      bigText: BigText(
                                        overflow: TextOverflow.ellipsis,
                                        text: userController.user.address,
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
                                        iconSize: 25.sp,
                                        size: 50.sp,
                                      ),
                                      bigText: BigText(text: 'Messages'),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //sign out
                                    AccountWidget(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          // Get.toNamed(Routes.USER_NAVIGATOR);
                                          Get.find<NavigatorUserController>()
                                              .currentIndex
                                              .value = 0;
                                        }
                                      },
                                      appIcon: AppIcon(
                                        onTap: () {},
                                        icon: Icons.logout,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: 25.sp,
                                        size: 50.sp,
                                      ),
                                      bigText:
                                          BigText(text: 'Login out'),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
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
                        height: 100.sp,
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.height20),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(Constants.EMPTY_ASSET)),
                        ),
                      ),
                      SizedBox(height: Dimensions.height30),
                      GestureDetector(
                        onTap: () =>
                            Get.offNamedUntil(Routes.SIGN_IN, (route) => false),
                        child: Container(
                          width: double.maxFinite,
                          height: 10.sp,
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
                            text: 'Login',
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
