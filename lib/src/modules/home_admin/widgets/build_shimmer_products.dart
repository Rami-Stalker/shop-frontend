import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../themes/app_decorations.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

class BuildShimmerProducts extends StatelessWidget {
  const BuildShimmerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Get.isDarkMode ? fCD : mCM,
            highlightColor: Get.isDarkMode ? mCH : mC,
          child: Container(
            margin: EdgeInsets.only(
              left: 20.sp,
              bottom: 10.sp,
            ),
            child: Row(
              children: [
                Container(
                  width: 100.sp,
                  height: 100.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.sp,
                    ),
                    color: Get.isDarkMode ? fCL : mCL,
                  ),
                ),
                SizedBox(
                  height: 70.sp,
                  child: Container(
                      decoration: AppDecoration.product(context, 20.sp).decoration,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 50.sp,
                                  height: 20.sp,
                                  color: Get.isDarkMode ? fCL : mCL,
                                ),
                              ],
                            ),
                            Container(
                              width: 70.sp,
                              height: 20.sp,
                              color: Get.isDarkMode ? fCL : mCL,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 70.sp,
                                  height: 20.sp,
                                  color: Get.isDarkMode ? fCL : mCL,
                                ),
                                Container(
                                  width: 70.sp,
                                  height: 20.sp,
                                  color: Get.isDarkMode ? fCL : mCL,
                                ),
                                Container(
                                  width: 70.sp,
                                  height: 20.sp,
                                  color: Get.isDarkMode ? fCL : mCL,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
