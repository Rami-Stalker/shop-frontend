import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/app/core/utils/dimensions.dart';
import 'package:shop_app/app/core/widgets/text_custom.dart';

import '../../widgets/big_text.dart';
import '../app_colors.dart';

class AppComponents {
  static Padding customBtn({
    Function? onPressed,
    BuildContext? context,
    required String txt,
    Color primary = Colors.blue,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(500, 50),
            primary: AppColors.backgroundColor,
          ),
          onPressed: () {
            onPressed!();
          },
          child: Text(
            txt,
            style: const TextStyle(fontSize: 15.0),
          ),
        ),
      );

  static Padding customTextField({
    TextEditingController? controller,
    required String hint,
    Widget? suffixIcon,
    Widget? prefixIcon,
    var validator,
    bool isobscure = false,
    var onsubmit,
    Function()? onTap,
    bool isread = false,
    double contentPadding = 10.0,
    fillColor = Colors.grey,
    double borderRadius = 10.0,
  }) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          onFieldSubmitted: onsubmit,
          scrollPadding: const EdgeInsets.only(top: 10.0),
          readOnly: isread,
          onTap: onTap,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.all(contentPadding),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.backgroundColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.backgroundColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            fillColor: fillColor,
            filled: true,
            hintStyle: TextStyle(
              color: Colors.grey[700],
            ),
            hintText: hint,
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          obscureText: isobscure,
        ),
      );

  static void showCustomDialog({
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

  static void showCustomSnackBar(
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
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
    );
  }

  static InkWell buildbottomsheet({
    required Icon icon,
    required String label,
    required Function() ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.height10),
        height: Dimensions.height45,
        //Get.isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        child: Row(
          children: [
            icon,
            SizedBox(width: Dimensions.width10),
            TextCustom(
              text: label,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }

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
