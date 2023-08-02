import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import 'package:shop_app/src/themes/app_decorations.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../core/widgets/big_text.dart';

class Components {
  static showCustomDialog({
    required BuildContext context,
    required String msg,
    required Function()? ok,
    required Color okColor,
  }) {
    // Get.dialog(widget);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                msg,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: ok,
                  child: Text('OK', style: TextStyle(color: okColor)),
                ),
              ],
            ));
  }

  static showSnackBar(
    String message, {
    bool isError = true,
    String title = 'Error',
    Color color = Colors.redAccent,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: BigText(
        text: title,
        color: mCL,
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: mCL,
        ),
      ),
      colorText: mCL,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
    );
  }

  static showbottomsheet(
    BuildContext context, {
    required Function() onTapCamera,
    required Function() onTapGallery,
  }) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsetsDirectional.only(
            top: 4,
          ),
          width: Dimensions.screenWidth,
          // height: 200.sp,
          color: Get.isDarkMode ? fCD : mCL,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildbottomsheet(context,
                  icon: Icons.camera,
                  text: 'Pick From Camera',
                  onTap: onTapCamera),
              Divider(
                color: Get.isDarkMode ? mCL : fCD,
              ),
              _buildbottomsheet(context,
                  icon: Icons.camera,
                  text: 'Pick From Gallery',
                  onTap: onTapGallery),
            ],
          ),
        ),
      ),
    );
  }

  static _buildbottomsheet(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppDecoration.appbarIcon(context, 10.sp).decoration,
        child: Row(
          children: [
            Icon(icon, color: colorPrimary),
            SizedBox(width: Dimensions.width15),
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  // static InkWell buildbottomsheet({
  //   required Icon icon,
  //   required String label,
  //   required Function() ontap,
  // }) {
  //   return InkWell(
  //     onTap: ontap,
  //     child: Container(
  //       padding: EdgeInsets.all(Dimensions.height10),
  //       height: Dimensions.height45,
  //       //Get.isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
  //       child: Row(
  //         children: [
  //           icon,
  //           SizedBox(width: Dimensions.width10),
  //           BigText(text: label),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // static void navigateTo(context, routes, arguments) =>
  //     Navigator.pushNamed(context, routes, arguments: arguments);

  // static void navigateAndFinish(context, routes, arguments) =>
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       routes,
  //       arguments: arguments,
  //       (Route<dynamic> route) => false,
  //     );
}
