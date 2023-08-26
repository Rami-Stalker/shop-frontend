import 'dart:io';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/dialogs/dialog_loading.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../navigator/controllers/navigator_user_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/picker/custom_image_picker.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../auth_login/controllers/login_controller.dart';
import '../../navigator/controllers/navigator_admin_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserController userController = Get.find<UserController>();
  ProfileController profileController = Get.find<ProfileController>();
  bool userLoggedIn = Get.find<LoginController>().userLoggedIn();

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<LoginController>(
        builder: (userCtrl) => userLoggedIn
            ? (!userCtrl.isLoading
                ? Padding(
                  padding: EdgeInsets.only(
          top: Dimensions.height20,
        ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //profile icon
                      SizedBox(
                        height: 120.sp,
                        width: Dimensions.screenWidth,
                        child: GestureDetector(
                          onTap: () {
                            CustomImagePicker().openImagePicker(
                              context: context,
                              handleFinish: (File image) {
                                setState(() {
                                  showDialogLoading(context);
                                  _image = image;
                                  profileController.updateAvatar(avatar: image);
                                });
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorPrimary,
                                width: 1.5.sp,
                              ),
                              // borderRadius: BorderRadius.circular(6.sp),
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.fill,
                                    )
                                  : DecorationImage(
                                      image: AssetImage(
                                          Constants.PERSON_ASSET),
                                      fit: BoxFit.contain,
                                    ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              PhosphorIcons.plusCircle,
                              color: colorPrimary,
                              size: 30.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      //body
                      AccountWidget(
                        onTap: () {
                          Get.toNamed(Routes.UPDATE_PROFILE);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.person,
                          backgroundColor: colorPrimary,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: userController.user.name,
                      ),
                      //phone
                      AccountWidget(
                        onTap: () {
                          Get.toNamed(Routes.UPDATE_PROFILE);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.phone,
                          backgroundColor: colorMedium,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: userController.user.phone,
                      ),
                      //email
                      AccountWidget(
                        onTap: () {},
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.email,
                          backgroundColor: colorMedium,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: userController.user.email,
                      ),
                      //address
                      AccountWidget(
                        onTap: () {
                          Get.toNamed(Routes.UPDATE_PROFILE);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.location_on,
                          backgroundColor: colorMedium,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: userController.user.address,
                      ),
                      //messages
                      AccountWidget(
                        onTap: () {},
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.message_outlined,
                          backgroundColor: Colors.redAccent,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: 'Messages',
                      ),
                      //sign out
                      AccountWidget(
                        onTap: () {
                          if (Get.find<LoginController>()
                              .userLoggedIn()) {
                            Get.find<LoginController>()
                                .clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>()
                                .clearCartHistory();
                            if (userController.user.type == "user") {
                              Get.find<NavigatorUserController>()
                                .currentIndex
                                .value = 0;
                            } else{
                              Get.find<NavigatorAdminController>()
                                .currentIndex
                                .value = 0;
                            }
                          }
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.logout,
                          backgroundColor: Colors.redAccent,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: 'Login out',
                      ),
                    ],
                  ),
                )
                : CustomLoader())
            : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: 170.sp,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.height20),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Constants.EMPTY_ASSET)),
                ),
              ),
              SizedBox(height: Dimensions.height30),
              Padding(
                padding: EdgeInsets.all(20.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextButton(
                        txt: 'Login',
                        onTap: () {
                          Get.offNamedUntil(Routes.LOGIN, (route) => false);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
              ),
      ),
    );
  }
}
