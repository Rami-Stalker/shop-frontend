
import '../../modules/home/controllers/home_controller.dart';
import '../../routes/app_pages.dart';
import '../../utils/sizer_custom/sizer.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../public/constants.dart';
import '../../themes/app_colors.dart';

class CategoryWidget extends GetView<HomeController> {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: AppConstants.categoryImages.length,
      padding: EdgeInsets.fromLTRB(5.sp, 0, 5.sp, 5.sp),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            AppNavigator.push(
              AppRoutes.CATEGORY_PRODUCT,
              arguments: {
                'title': AppConstants.categoryImages[index]['title']!,
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 140.sp,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      image: DecorationImage(
                        image: AssetImage(
                          AppConstants.categoryImages[index]['image']!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorBranch.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      child: Text(
                        AppConstants.categoryImages[index]['title']!,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24.sp, color: mCL),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.sp),
            ],
          ),
        );
      },
    );
  }
}
