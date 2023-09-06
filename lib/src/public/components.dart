import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../controller/app_controller.dart';
import '../controller/theme_controller.dart';
import '../models/notification_model.dart';
import '../routes/app_pages.dart';
import '../themes/app_colors.dart';

import '../themes/app_decorations.dart';
import '../themes/font_family.dart';
import '../themes/theme_service.dart';
import '../utils/sizer_custom/sizer.dart';

class Components {
  static AppBar customAppBar(
    BuildContext context,
    String title,
  ) {
    return AppBar(
      centerTitle: true,
      title: AppText(title),
      leading: Container(
        padding: EdgeInsets.all(8.sp),
        child: InkWell(
          onTap: () => AppNavigator.pop(),
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
          SizerUtil.width,
          20.sp,
        ),
      ),
    );
  }

  static AppBar customAppBarHome(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: AppGet.authGet.userModel?.address == null
          ? Text(
              'Ramy Shop',
              style: TextStyle(
                color: colorPrimary,
                fontSize: 20.sp,
                fontFamily: FontFamily.dancing,
              ),
            )
          : Container(
              width: 200.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ramy Shop',
                    style: TextStyle(
                      color: colorPrimary,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.dancing,
                    ),
                  ),
                  AppText(
                    type: TextType.small,
                    AppGet.authGet.userModel?.address ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
      actions: [
        AppGet.authGet.onAuthCheck()
            ? FutureBuilder<List<NotificationModel>>(
                future: AppGet.notificationGet.getNotofications(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int isSeen = 0;
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].isSeen == false) {
                        isSeen += 1;
                      }
                    }
                    return Container(
                      padding: EdgeInsets.all(8.sp),
                      child: GestureDetector(
                        onTap: () {
                          AppNavigator.push(
                            Routes.NOTIFICATION,
                            arguments: snapshot.data,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.sp),
                          decoration: AppDecoration.appbarIcon(context, 5.sp)
                              .decoration,
                          child: Stack(
                            children: [
                              Icon(
                                Icons.notifications,
                                size: 20.sp,
                                color: colorPrimary,
                              ),
                              isSeen != 0
                                  ? Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: CircleAvatar(
                                        radius: 5.sp,
                                        backgroundColor: mCL,
                                        child: CircleAvatar(
                                          radius: 4.sp,
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.all(8.sp),
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration:
                          AppDecoration.appbarIcon(context, 5.sp).decoration,
                      child: Icon(
                        Icons.notifications,
                        size: 20.sp,
                        color: colorPrimary,
                      ),
                    ),
                  );
                },
              )
            : Container(
                padding: EdgeInsets.all(8.sp),
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration:
                      AppDecoration.appbarIcon(context, 5.sp).decoration,
                  child: Icon(
                    Icons.notifications,
                    size: 20.sp,
                    color: colorPrimary,
                  ),
                ),
              ),
        GetBuilder<ThemeController>(
          builder: (themeController) {
            return Container(
              padding: EdgeInsets.all(8.sp),
              child: GestureDetector(
                onTap: () {
                  themeController.onChangeTheme(
                    ThemeService.currentTheme == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration:
                      AppDecoration.appbarIcon(context, 5.sp).decoration,
                  child: Icon(
                    Get.isDarkMode
                        ? Icons.wb_sunny_outlined
                        : Icons.nightlight_round_outlined,
                    size: 20.sp,
                    color: colorPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp),
          child: InkWell(
            onTap: () => AppNavigator.push(Routes.SEARCH),
            child: Container(
              width: SizerUtil.width,
              padding: EdgeInsets.all(10.sp),
              decoration: AppDecoration.textfeild(context, 5.sp).decoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search your desired food",
                    style: TextStyle(
                      color: mCH,
                    ),
                  ),
                  Icon(
                    Icons.search,
                  ),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size(
          SizerUtil.width,
          50.sp,
        ),
      ),
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

  static showSnackBar(
    String message, {
    String title = 'Error',
    Color color = Colors.redAccent,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: FontFamily.lato,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: mCL,
          fontFamily: FontFamily.lato,
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
