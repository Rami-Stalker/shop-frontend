import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../core/widgets/app_icon.dart';
import '../routes/app_pages.dart';
import '../themes/app_colors.dart';

import '../themes/app_decorations.dart';
import '../utils/sizer_custom/sizer.dart';

class Components {
  static AppBar customAppBar(
    BuildContext context,
    String title,
  ) {
    return AppBar(
      title: AppText(title),
      leading: Padding(
        padding: EdgeInsets.all(8.sp),
        child: GestureDetector(
          onTap: () {
            AppNavigator.pop();
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: colorPrimary,
                ),
                shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back,
              size: 15.sp,
              color: Get.isDarkMode ? mCL : colorBlack,
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        child: Divider(),
        preferredSize: Size(
          SizerUtil.width,
          10.sp,
        ),
      ),
    );
  }

  static Container customHeadIconViews(
    String title,
    IconData icon,
    Function() onTap,
  ) {
    return Container(
      color: colorPrimary,
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20.sp,
          ),
          AppText(title),
          Container(
            child: AppIcon(
              onTap: onTap,
              icon: icon,
              iconColor: Get.isDarkMode ? colorPrimary : colorBlack,
              backgroundColor: colorBranch,
            ),
          ),
        ],
      ),
    );
  }

  static InkWell customSearch(BuildContext context)=> InkWell(
          onTap: () => AppNavigator.push(AppRoutes.SEARCH_PRODUCT),
          child: Container(
            width: SizerUtil.width,
            padding: EdgeInsets.all(10.sp),
            decoration:
                AppDecoration.productFavoriteCart(context, 6.sp).decoration,
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: colorPrimary,
                ),
                SizedBox(width: 10.sp),
                AppText(
                  'search_desired_food'.tr,
                  type: TextType.small,
                ),
              ],
            ),
          ),
        );

  static Container customHeadViews(String title) {
    return Container(
      color: colorPrimary,
      padding: EdgeInsets.all(10.sp),
      child: Center(child: AppText(title)),
    );
  }

  static Container customRating(String rating) {
    return Container(
      padding: EdgeInsets.all(
        5.sp,
      ),
      decoration: BoxDecoration(
        color: colorStar,
        borderRadius: BorderRadius.circular(
          15.sp,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: colorBlack,
            size: 15.sp,
          ),
          Text(
            rating,
            style: TextStyle(
              color: colorBlack,
            ),
          )
        ],
      ),
    );
  }

  static Container customContainer(
    BuildContext context,
    Widget child,
  ) {
    return Container(
      padding: EdgeInsets.all(
        10.sp,
      ),
      decoration: AppDecoration.productFavoriteCart(context, 6.sp).decoration,
      child: child,
    );
  }

  static showCustomDialog({
    required BuildContext context,
    required String msg,
    required Function()? ok,
    required Color okColor,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                msg,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 16.sp,
                    ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => AppNavigator.pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: ok,
                  child: Text('OK', style: TextStyle(color: okColor)),
                ),
              ],
            ));
  }

  static InkWell buildbottomsheet({
    required Icon icon,
    required String label,
    required Function() ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(10.sp),
        height: 45.sp,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: mCM,
              child: icon,
            ),
            SizedBox(width: 10.sp),
            AppText(label),
          ],
        ),
      ),
    );
  }

  static void showSnackBar(
    String message, {
    String title = 'Error',
    Color color = Colors.redAccent,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: AppText(
        title,
      ),
      messageText: AppText(
        message,
      ),
      colorText: mCL,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
    );
  }

  static showToast(
    String msg, {
    Color color = Colors.redAccent,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: mCL,
      fontSize: 16.0,
    );
  }

  static Future<String> cloudinaryPublic(String imgPath) async {
    int random = Random().nextInt(1000);

    final cloudinary = CloudinaryPublic('dvn9z2jmy', 'lkma7rx1');

    CloudinaryResponse res = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        imgPath,
        folder: "$imgPath$random",
      ),
    );

    return res.secureUrl;
  }
}
