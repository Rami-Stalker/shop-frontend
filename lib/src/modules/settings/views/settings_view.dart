import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/src/modules/settings/controllers/settings_controller.dart';
import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/resources/local/user_local.dart';
import 'package:shop_app/src/themes/theme_service.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';

class SettingsView extends GetView<SettingsCotnroller> {
  const SettingsView({super.key});

  buildBottomsheet() => Get.bottomSheet(
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.sp),
              ),
              color: Get.isDarkMode ? colorBlack : mCL,
            ),
            padding: const EdgeInsetsDirectional.only(
              top: 4,
            ),
            width: SizerUtil.width,
            height: 130.sp,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20.sp,
                      ),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                Components.buildbottomsheet(
                  icon: Icon(
                    Icons.camera_alt,
                    color: colorBlack,
                  ),
                  label: 'search_desired_food'.tr,
                  ontap: () => controller.selectImageFromCamera(),
                ),
                Components.buildbottomsheet(
                  icon: Icon(
                    Icons.photo_library,
                    color: colorBlack,
                  ),
                  label: "Select Image From Gallery",
                  ontap: () => controller.selectImageFromGallery(),
                ),
              ],
            ),
          ),
        ),
        elevation: 0.4,
      );

  Widget buildProfileImage() => GestureDetector(
        onTap: () => buildBottomsheet(),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 30.sp,
              backgroundColor: mCL,
              child: controller.photoFile != null
                  ? CircleAvatar(
                      radius: 28.sp,
                      backgroundColor: fCD,
                      backgroundImage: FileImage(
                        controller.photoFile!,
                      ),
                    )
                  : CircleAvatar(
                      radius: 28.sp,
                      backgroundColor: fCD,
                      backgroundImage: NetworkImage(
                        UserLocal().getUser()?.photo ?? '',
                      ),
                    ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: CircleAvatar(
                radius: 10.sp,
                backgroundColor: mCL,
                child: CircleAvatar(
                  radius: 8.sp,
                  backgroundColor: mCH,
                  child: Icon(Icons.camera_alt, size: 8.sp),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AuthController>(builder: (authController) {
        UserModel userInfo = authController.userModel ??
            UserModel(
                id: "",
                photo: "",
                blurHash: "",
                name: "",
                email: "",
                phone: "",
                password: "",
                address: "",
                type: "user",
                tokenFCM: "",
                token: "");
        return ListView(
          children: [
            Container(
              color: colorPrimary,
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30.sp,
                  ),
                  AppText('settings'.tr),
                  userInfo.type == "user" && userInfo.name != ""
                      ? Row(
                          children: [
                            AppIcon(
                              onTap: () =>
                                  AppNavigator.push(AppRoutes.FAVORITE),
                              icon: Icons.favorite,
                              iconColor:
                                  Get.isDarkMode ? colorPrimary : colorBlack,
                              backgroundColor: colorBranch,
                            ),
                            SizedBox(width: 10.sp),
                            AppIcon(
                              onTap: () => AppGet.authGet.logOut(),
                              icon: Icons.logout_outlined,
                              iconColor: Colors.red,
                              backgroundColor: colorBranch,
                            ),
                          ],
                        )
                      : AppIcon(
                          onTap: () => AppGet.authGet.logOut(),
                          icon: Icons.logout_outlined,
                          iconColor: Colors.red,
                          backgroundColor: colorBranch,
                        ),
                ],
              ),
            ),
            AppGet.authGet.onAuthCheck()
                ? ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10.sp),
                    children: [
                      Components.customSearch(context),
                      SizedBox(height: 20.sp),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(userInfo.name),
                              SizedBox(height: 5.sp),
                              AppText(
                                userInfo.email,
                                type: TextType.small,
                              ),
                            ],
                          ),
                          Spacer(),
                          buildProfileImage(),
                        ],
                      ),
                      GetBuilder<SettingsCotnroller>(
                        builder: (settingsCotnroller) {
                          return settingsCotnroller.photoFile != null
                              ? TextButton(
                                  onPressed: () {
                                    settingsCotnroller.updateAvatar(
                                      photo: settingsCotnroller.photoFile,
                                    );
                                  },
                                  child: Text('save'.tr),
                                )
                              : SizedBox();
                        },
                      ),
                      SizedBox(height: 30.sp),
                      Components.customContainer(
                        context,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, color: fCL),
                                SizedBox(width: 20.sp),
                                AppText('about'.tr),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    AppNavigator.push(AppRoutes.EDIT_INFO_USER);
                                  },
                                  child: AppText(
                                    'edit'.tr,
                                    type: TextType.medium,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.sp),
                            _infoSettings(
                              context: context,
                              title: 'full_name'.tr,
                              subtitle: '${userInfo.name}',
                            ),
                            SizedBox(height: 10.sp),
                            _infoSettings(
                              context: context,
                              title: 'email'.tr,
                              subtitle: '${userInfo.email}',
                            ),
                            SizedBox(height: 10.sp),
                            _infoSettings(
                              context: context,
                              title: 'phone'.tr,
                              subtitle: '${userInfo.phone}',
                            ),
                            SizedBox(height: 10.sp),
                            _infoSettings(
                              context: context,
                              title: 'address'.tr,
                              subtitle: '${userInfo.address.split(' ').first}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      Components.customContainer(
                        context,
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.payment, color: fCL),
                                SizedBox(width: 20.sp),
                                AppText('payments_settings'.tr),
                                Spacer(),
                                AppText(
                                  'edit'.tr,
                                  type: TextType.medium,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.sp),
                            _infoSettings(
                              context: context,
                              title: 'full_name'.tr,
                              subtitle: '${userInfo.name}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      Components.customContainer(
                        context,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.settings, color: fCL),
                                SizedBox(width: 20.sp),
                                AppText('settings_settings'.tr),
                              ],
                            ),
                            SizedBox(height: 20.sp),
                            InkWell(
                              onTap: () {
                                AppNavigator.push(AppRoutes.LANGUAGE);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    'language'.tr,
                                    type: TextType.medium,
                                  ),
                                  AppText(
                                    'lan'.tr,
                                    type: TextType.small,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  'theme'.tr,
                                  type: TextType.medium,
                                ),
                                Switch(
                                  value: Get.isDarkMode ? true : false,
                                  onChanged: (val) {
                                    themeService.changeTheme();
                                  },
                                  activeColor: colorPrimary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
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
                      SizedBox(height: 20.sp),
                      Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppTextButton(
                                txt: 'login'.tr,
                                onTap: () {
                                  AppNavigator.popUntil(AppRoutes.LOGIN);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        );
      }),
    );
  }

  Row _infoSettings({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          title,
          type: TextType.medium,
        ),
        AppText(
          subtitle,
          type: TextType.small,
        ),
      ],
    );
  }
}
