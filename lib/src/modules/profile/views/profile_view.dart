import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/modules/profile/controllers/profile_controller.dart';
import 'package:shop_app/src/public/components.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/blurhash.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../public/constants.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/profile_widget.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: colorPrimary,
              ),
        ),
        leading: GestureDetector(
          onTap: () {
            AppNavigator.push(AppRoutes.SETTINGS);
          },
          child: Icon(
            Icons.settings,
            color: Get.isDarkMode ? mCL : colorBlack,
          ),
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (authController) => AppGet.authGet.onAuthCheck()
            ? (!authController.isLoading && authController.userModel != null
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 10.sp),
                      //profile icon
                      SizedBox(
                        height: 150.sp,
                        width: SizerUtil.height,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                height: 100.sp,
                                width: 100.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000.sp),
                                  child: BlurHash(
                                    hash: authController.userModel!.blurHash,
                                    image: authController.userModel!.photo,
                                    imageFit: BoxFit.cover,
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.sp),
                              AppText(authController.userModel!.name),
                              SizedBox(height: 5.sp),
                              AppText(
                                authController.userModel!.address
                                    .split(' ')
                                    .first,
                                type: TextType.medium,
                              ),
                            ],
                          ),
                        ),

                        // GestureDetector(
                        //   onTap: () {
                        //     CustomImagePicker().openImagePicker(
                        //       context: context,
                        //       handleFinish: (File image) async {
                        //         showDialogLoading(context);
                        //         AppGet.authGet.updateAvatar(avatar: image);
                        //       },
                        //     );
                        //   },
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     child: Container(
                        //       height: 105.sp,
                        //       width: 105.sp,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         border: Border.all(
                        //           color: colorPrimary,
                        //           width: 3.sp,
                        //         ),
                        //       ),
                        //       alignment: Alignment.center,
                        //       child: Container(
                        //         height: 95.sp,
                        //         width: 95.sp,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(1000.sp),
                        //           child: BlurHash(
                        //             hash: AppGet.authGet.userModel!.blurHash,
                        //             image: AppGet.authGet.userModel!.image,
                        //             imageFit: BoxFit.cover,
                        //             color: colorPrimary,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                      SizedBox(height: 10.sp),
                      //body
                      ListTile(
                        title: AppText('About'),
                        leading: Icon(Icons.person),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Components.customContainer(
                          context,
                          Expanded(
                            child: Text(
                              '${authController.userModel!.name} , ${authController.userModel!.phone} , ${authController.userModel!.address}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.sp),
                      AccountWidget(
                        onTap: () {
                          AppNavigator.push(AppRoutes.EDIT_INFO_USER);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.person,
                          backgroundColor: colorPrimary,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: authController.userModel!.name,
                      ),
                      //phone
                      AccountWidget(
                        onTap: () {
                          AppNavigator.push(AppRoutes.EDIT_INFO_USER);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.phone,
                          backgroundColor: colorBranch,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: authController.userModel!.phone,
                      ),
                      //email
                      AccountWidget(
                        onTap: () {},
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.email,
                          backgroundColor: colorBranch,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: authController.userModel!.email,
                      ),
                      //address
                      AccountWidget(
                        onTap: () {
                          AppNavigator.push(AppRoutes.EDIT_INFO_USER);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.location_on,
                          backgroundColor: colorBranch,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: authController.userModel!.address,
                      ),
                      //favorite
                      AccountWidget(
                        onTap: () {
                          AppNavigator.push(AppRoutes.FAVORITE);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.favorite,
                          backgroundColor: Colors.redAccent,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: "Favorites",
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
                          authController.logOut();
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
                  )
                : CustomLoader())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: AppConstants().loginLottie,
                  ),
                  SizedBox(height: 30.sp),
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextButton(
                            txt: 'Login',
                            onTap: () {
                              Get.offNamedUntil(
                                  AppRoutes.LOGIN, (route) => false);
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
