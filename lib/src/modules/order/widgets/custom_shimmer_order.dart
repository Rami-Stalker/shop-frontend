import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

class CustomShimmerOrder extends StatelessWidget {
  const CustomShimmerOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Get.isDarkMode ? fCD : mCM,
            highlightColor: Get.isDarkMode ? mCH : mC,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.sp,
                      height: 20.sp,
                      color: Get.isDarkMode ? fCL : mCL,
                    ),
                    SizedBox(height: 10.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70.sp,
                              width: 70.sp,
                              margin: EdgeInsets.only(
                                right: 5.sp,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  7.sp,
                                ),
                                color: Get.isDarkMode ? fCL : mCL,
                              ),
                            ),
                            Container(
                              height: 70.sp,
                              width: 70.sp,
                              margin: EdgeInsets.only(
                                right: 5.sp,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  7.sp,
                                ),
                                color: Get.isDarkMode ? fCL : mCL,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80.sp,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 60.sp,
                                height: 20.sp,
                                color: Get.isDarkMode ? fCL : mCL,
                              ),
                              SizedBox(height: 10.sp),
                              Container(
                                width: 40.sp,
                                height: 20.sp,
                                color: Get.isDarkMode ? fCL : mCL,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
