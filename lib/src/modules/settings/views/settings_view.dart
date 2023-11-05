import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/themes/theme_service.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_decorations.dart';
import '../../../utils/blurhash.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.customAppBar(
        context,
        'settings',
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        UserModel userData = authController.userModel!;
        return ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(10.sp),
          children: [
            InkWell(
              onTap: () => AppNavigator.push(AppRoutes.SEARCH_PRODUCT),
              child: Container(
                width: SizerUtil.width,
                padding: EdgeInsets.all(10.sp),
                decoration:
                    AppDecoration.productFavoriteCart(context, 6.sp).decoration,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.search,
                      color: colorPrimary,
                    ),
                    SizedBox(width: 10.sp),
                    AppText(
                      "Search your desired food",
                      type: TextType.small,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(userData.name),
                    SizedBox(height: 5.sp),
                    AppText(
                      userData.email,
                      type: TextType.small,
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 40.sp,
                  width: 40.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000.sp),
                    child: BlurHash(
                      hash: authController.userModel!.blurHash,
                      image: authController.userModel!.image,
                      imageFit: BoxFit.cover,
                      color: colorPrimary,
                    ),
                  ),
                ),
              ],
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
                    subtitle: '${authController.userModel!.name}',
                  ),
                  SizedBox(height: 10.sp),
                  _infoSettings(
                    context: context,
                    title: 'email'.tr,
                    subtitle: '${authController.userModel!.email}',
                  ),
                  SizedBox(height: 10.sp),
                  _infoSettings(
                    context: context,
                    title: 'phone'.tr,
                    subtitle: '${authController.userModel!.phone}',
                  ),
                  SizedBox(height: 10.sp),
                  _infoSettings(
                    context: context,
                    title: 'address'.tr,
                    subtitle:
                        '${authController.userModel!.address.split(' ').first}',
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
                      AppText('Payments Settings'),
                      Spacer(),
                      AppText(
                        'Edit',
                        type: TextType.medium,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  _infoSettings(
                    context: context,
                    title: 'Full name',
                    subtitle: '${authController.userModel!.name}',
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
                      AppText('Settings Settings'),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  InkWell(
                    onTap: (){
                      AppNavigator.push(AppRoutes.LANGUAGE);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          'Languages',
                          type: TextType.medium,
                        ),
                        AppText(
                            'English',
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
                        'Themes',
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
