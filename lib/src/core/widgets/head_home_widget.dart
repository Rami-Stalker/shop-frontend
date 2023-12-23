import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../../public/components.dart';
import 'app_text.dart';
import '../../models/notification_model.dart';
import '../../resources/local/user_local.dart';
import '../../routes/app_pages.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_decorations.dart';
import '../../themes/font_family.dart';
import '../../themes/theme_service.dart';
import '../../utils/sizer_custom/sizer.dart';

class HeadHomeWidget extends StatelessWidget {
  const HeadHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserLocal().getUser()?.address == '' ||
                      UserLocal().getUser()?.address == null
                  ? RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Ramy',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.dancing,
                              color: colorPrimary,
                            ),
                          ),
                          TextSpan(
                            text: 'shop',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.dancing,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: 200.sp,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Ramy',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: FontFamily.dancing,
                                    color: colorPrimary,
                                  ),
                                ),
                                TextSpan(
                                  text: 'shop',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: FontFamily.dancing,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppText(
                            type: TextType.small,
                            UserLocal().getUser()?.address ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
              Row(
                children: [
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
                                // padding: EdgeInsets.all(8.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    AppNavigator.push(
                                      AppRoutes.NOTIFICATION,
                                      arguments: snapshot.data,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.sp),
                                    decoration:
                                        AppDecoration.appbarIcon(context, 5.sp)
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
                              child: Container(
                                padding: EdgeInsets.all(5.sp),
                                decoration:
                                    AppDecoration.appbarIcon(context, 5.sp)
                                        .decoration,
                                child: Icon(
                                  Icons.notifications,
                                  size: 20.sp,
                                  color: colorPrimary,
                                ),
                              ),
                            );
                          },
                        )
                      : 
                      Container(
                          child: Container(
                            padding: EdgeInsets.all(5.sp),
                            decoration: AppDecoration.appbarIcon(context, 5.sp)
                                .decoration,
                            child: Icon(
                              Icons.notifications,
                              size: 20.sp,
                              color: colorPrimary,
                            ),
                          ),
                        ),
                  SizedBox(width: 8.sp),
                  Container(
                        child: GestureDetector(
                          onTap: () {
                            themeService.changeTheme();
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.sp),
                            decoration: AppDecoration.appbarIcon(context, 5.sp)
                                .decoration,
                            child: Icon(
                              Get.isDarkMode
                                  ? Icons.wb_sunny_outlined
                                  : Icons.nightlight_round_outlined,
                              size: 20.sp,
                              color: colorPrimary,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          Components.customSearch(context),
        ],
      ),
    );
  }
}