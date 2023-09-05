import 'dart:io';

import 'package:shop_app/src/controller/app_controller.dart';
import '../../../core/dialogs/dialog_loading.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/blurhash.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/picker/custom_image_picker.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/profile_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool userLoggedIn = AppGet.authGet.onAuthCheck();

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
      body: GetBuilder<AuthController>(
        builder: (authController) => userLoggedIn
            ? (!authController.isLoading && authController.userModel != null
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 10.sp),
                      //profile icon
                      SizedBox(
                        height: 120.sp,
                        width: SizerUtil.height,
                        child: GestureDetector(
                  onTap: () {
                    CustomImagePicker().openImagePicker(
                      context: context,
                      handleFinish: (File image) async {
                        showDialogLoading(context);
                        AppGet.authGet.updateAvatar(avatar: image);
                      },
                    );
                  },
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    child: Container(
                      height: 105.sp,
                      width: 105.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorPrimary,
                          width: 3.sp,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 95.sp,
                        width: 95.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000.sp),
                          child: BlurHash(
                            hash: AppGet.authGet.userModel!.blurHash,
                            image: AppGet.authGet.userModel!.image,
                            imageFit: BoxFit.cover,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                        // child: GestureDetector(
                        //   onTap: () {
                        //     CustomImagePicker().openImagePicker(
                        //       context: context,
                        //       handleFinish: (File image) {
                        //         setState(
                        //           () {
                        //             showDialogLoading(context);
                        //             _image = image;
                        //             AppGet.authGet.updateAvatar(avatar: image);
                        //           },
                        //         );
                        //       },
                        //     );
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       border: Border.all(
                        //         color: colorPrimary,
                        //         width: 1.5.sp,
                        //       ),
                        //       // borderRadius: BorderRadius.circular(6.sp),
                        //       image: _image != null
                        //           ? DecorationImage(
                        //               image: FileImage(_image!),
                        //               fit: BoxFit.fill,
                        //             )
                        //           : DecorationImage(
                        //               image: AssetImage(Constants.PERSON_ASSET),
                        //               fit: BoxFit.contain,
                        //             ),
                        //     ),
                        //     alignment: Alignment.center,
                        //     child: Icon(
                        //       PhosphorIcons.plusCircle,
                        //       color: colorPrimary,
                        //       size: 30.sp,
                        //     ),
                        //   ),
                        // ),
                      ),
                      SizedBox(height: 10.sp),
                      //body
                      AccountWidget(
                        onTap: () {
                          AppNavigator.push(Routes.UPDATE_PROFILE);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.person,
                          backgroundColor: colorPrimary,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: AppGet.authGet.userModel!.name,
                      ),
                      //phone
                      AccountWidget(
                        onTap: () {
                          AppNavigator.push(Routes.UPDATE_PROFILE);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.phone,
                          backgroundColor: colorMedium,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: AppGet.authGet.userModel!.phone,
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
                        text: AppGet.authGet.userModel!.email,
                      ),
                      //address
                      AccountWidget(
                        onTap: () {
                          AppNavigator.push(Routes.UPDATE_PROFILE);
                        },
                        appIcon: AppIcon(
                          onTap: () {},
                          icon: Icons.location_on,
                          backgroundColor: colorMedium,
                          iconColor: mCL,
                          iconSize: 20.sp,
                          size: 40.sp,
                        ),
                        text: AppGet.authGet.userModel!.address,
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
                    // height: 230.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Constants().loginLottie,
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
