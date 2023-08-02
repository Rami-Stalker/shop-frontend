import 'package:shop_app/src/modules/home/controllers/home_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';

class HomeCategories extends GetView<HomeController> {
  const HomeCategories({Key? key}) : super(key: key);

  void navigateToCategoryView(BuildContext context, String category) {
    Get.toNamed(Routes.HOME_CATEGORY_DEALS, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.sp),
      child: SizedBox(
        height: 70.sp,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: Constants.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 280,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                navigateToCategoryView(
                  context,
                  Constants.categoryImages[index]['title']!,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                elevation: 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Image.asset(
                        Constants.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorMedium.withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(10.sp),
                      ),
                    ),
                    Text(
                      Constants.categoryImages[index]['title']!,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
