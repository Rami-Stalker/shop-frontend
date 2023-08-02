import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/controller/notification_controller.dart';
import 'package:shop_app/src/core/widgets/big_text.dart';
import 'package:shop_app/src/core/widgets/small_text.dart';
import 'package:shop_app/src/models/notification_model.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

class HomeNitification extends StatefulWidget {
  const HomeNitification({super.key});

  @override
  State<HomeNitification> createState() => _HomeNitificationState();
}

class _HomeNitificationState extends State<HomeNitification> {
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.black,
          ),
        ),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ],
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: Icon(Icons.arrow_back_ios, size: 10.sp),
            ),
          ),
        ),
        bottom: PreferredSize(
            child: Divider(), preferredSize: Size(Dimensions.screenWidth, 20)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.height10,
          vertical: Dimensions.height10,
        ),
        child: Expanded(
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        5.sp,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: notification.notification.title,
                            ),
                            SmallText(
                              text: timeAgoCustom(
                                notification.createdAt,
                              ),
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.sp),
                        SmallText(
                          text: notification.notification.body,
                          maxline: 2,
                          color: Colors.black,
                          size: 13.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
