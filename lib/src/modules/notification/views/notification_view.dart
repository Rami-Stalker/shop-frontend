import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/public/components.dart';
import '../../../models/notification_model.dart';
import '../../../themes/app_decorations.dart';
import '../../../utils/sizer_custom/sizer.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    AppGet.notificationGet.seenNotofication();
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
      appBar: Components.customAppBar(
        context,
        "Notificaton",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 10.sp,
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
                  padding: EdgeInsets.fromLTRB(10.sp, 5.sp, 5.sp, 5.sp),
                  decoration:
                      AppDecoration.appbarIcon(context, 5.sp).decoration,
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
