import 'package:shop_app/app/core/utils/dimensions.dart';
import 'package:shop_app/app/modules/home/controllers/home_controller.dart';

import '../../../core/utils/app_colors.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../core/utils/constants/global_variables.dart';
import '../../../routes/app_pages.dart';

class HomeCategories extends GetView<HomeController> {
  const HomeCategories({Key? key}) : super(key: key);

  void navigateToCategoryView(BuildContext context, String category) {
    Get.toNamed(Routes.HOME_CATEGORY_DEALS, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width10),
      child: SizedBox(
        height: Dimensions.height45 * 2,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 280,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                navigateToCategoryView(
                  context,
                  GlobalVariables.categoryImages[index]['title']!,
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
                        GlobalVariables.categoryImages[index]['image']!,
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
                      GlobalVariables.categoryImages[index]['title']!,
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
