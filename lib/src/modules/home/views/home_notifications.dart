import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/notification_controller.dart';
import '../../../models/notification_model.dart';
import '../../../themes/app_decorations.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../themes/app_colors.dart';

class HomeNotification extends StatefulWidget {
  const HomeNotification({super.key});

  @override
  State<HomeNotification> createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  @override
  void initState() {
    Get.find<NotificationController>().seenNotofication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> argument = Get.arguments;

    String timeAgoCustom(DateTime date) {
      Duration diff = DateTime.now().difference(date);
      if (diff.inDays > 365) {
        return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
      }
      if (diff.inDays > 30) {
        return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
      }
      if (diff.inDays > 7) {
        return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
      }
      if (diff.inDays > 0) {
        return DateFormat.E().add_jm().format(date);
      }
      if (diff.inHours > 0) {
        return "Today ${DateFormat('jm').format(date)}";
      }
      if (diff.inMinutes > 0) {
        return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
      }
      return "just now";
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.height10,
          vertical: Dimensions.height10,
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: argument.length,
          itemBuilder: (_, index) {
            var notification = argument[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10.sp),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(
                    right: 5.sp,
                    left: Dimensions.width10,
                    top: 5.sp,
                    bottom: 5.sp,
                  ),
                  decoration: AppDecoration.appbarIcon(context, 5.sp)
                        .decoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification.notification.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            timeAgoCustom(
                              notification.createdAt,
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.sp),
                      Text(
                        notification.notification.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
