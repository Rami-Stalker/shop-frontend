import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../themes/app_colors.dart';

import '../core/widgets/big_text.dart';
import '../themes/app_decorations.dart';
import '../utils/sizer_custom/sizer.dart';

class Components {

  static AppBar appAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    leading: Container(
      padding: EdgeInsets.all(8.sp),
      child: InkWell(
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.all(5.sp),
          decoration: AppDecoration.appbarIcon(context, 5.sp).decoration,
          child: Icon(
            Icons.arrow_back_ios,
            size: 15.sp,
            color: Get.isDarkMode ? mCL : colorBlack,
          ),
        ),
      ),
    ),
    bottom: PreferredSize(
      child: Divider(),
      preferredSize: Size(
        Dimensions.screenWidth,
        20,
      ),
    ),
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
                style: TextStyle(
                  color: colorBlack,
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
    String title = 'Error',
    Color color = Colors.redAccent,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: BigText(
        text: title,
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
}
