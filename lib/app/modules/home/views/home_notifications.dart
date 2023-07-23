import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/app/controller/notification_controller.dart';
import 'package:shop_app/app/core/widgets/big_text.dart';
import 'package:shop_app/app/core/widgets/small_text.dart';
import 'package:shop_app/app/models/notification_model.dart';

import '../../../core/utils/dimensions.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width30 - 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: Dimensions.height15),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.height10),
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
                                  Dimensions.radius15 - 8),
                            ),
                            child: Icon(Icons.arrow_back_ios,
                                size: Dimensions.iconSize16 - 2),
                          ),
                        ),
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font16 + 2,
                          ),
                        ),
                        Container(
                          width: Dimensions.height45 - 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10 - 2,
                    ),
                    Divider(),
                  ],
                ),
              ),
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: argument.length,
                        itemBuilder: (_, index) {
                          var notification = argument[index];
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: Dimensions.height10),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(
                                  right: Dimensions.width10,
                                  left: Dimensions.width20,
                                  top: Dimensions.width10,
                                  bottom: Dimensions.width10,
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
                                      Dimensions.radius15 - 10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                    SizedBox(height: Dimensions.height10 - 2),
                                    SmallText(
                                      text: notification.notification.body,
                                      maxline: 2,
                                      color: Colors.black,
                                      size: Dimensions.font16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
