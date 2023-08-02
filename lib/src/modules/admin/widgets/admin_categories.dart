import 'package:shop_app/src/modules/admin/controllers/admin_controller.dart';

import '../../../core/utils/app_colors.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/sizer_custom/sizer.dart';

class AdminCategories extends GetView<AdminController> {
  const AdminCategories({Key? key}) : super(key: key);

  void navigateToCategoryView(BuildContext context, String category) {
    Get.toNamed(Routes.ADMIN_CATEGORY_DEALS, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width10),
      child: SizedBox(
        height: 90.sp,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: Constants.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 280.sp,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                controller.fetchCategoryProduct(
                    category: Constants.categoryImages[index]['title']!);
                navigateToCategoryView(
                  context,
                  Constants.categoryImages[index]['title']!,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
                elevation: 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
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
                        color: AppColors.originColor.withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                    Text(
                      Constants.categoryImages[index]['title']!,
                      style: TextStyle(
                        fontSize: Dimensions.font26,
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
