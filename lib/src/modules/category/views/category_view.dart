import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/routes/app_pages.dart';

import '../../../controller/app_controller.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../core/widgets/product_widget.dart';
import '../../../models/product_model.dart';
import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../controllers/category_controller.dart';

class CatigoryView extends GetView<CategoryController> {
  const CatigoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: AppText(title),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: AppIcon(
            onTap: () => AppNavigator.pop(),
            icon: Icons.arrow_back_ios,
            backgroundColor: colorBranch,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<List<ProductModel>?>(
              future: controller.fetchCategoryProduct(
                  category: title.toLowerCase()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          var product = snapshot.data![index];
                          return ProductWidget(
                            onTap: () {
                              if (AppGet.authGet.userModel?.type == 'admin') {
                                AppNavigator.push(
                                  AppRoutes.EDIT_PRODUCT,
                                  arguments: {
                                    'product': product,
                                    'ratings': product.ratings,
                                  },
                                );
                              } else {
                                AppNavigator.push(
                                  AppRoutes.DETAILS_PRODUCT_RATING,
                                  arguments: {
                                    'product': product,
                                    'ratings': product.ratings,
                                  },
                                );
                              }
                            },
                            product: product,
                            index: index,
                          );
                        }),
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Expanded(
                    child: NoDataPage(
                      text: "Your cart history is empty",
                      imgPath: AppConstants.EMPTY_ASSET,
                    ),
                  );
                }
                return const Expanded(child: CustomLoader());
              }),
        ],
      ),
    );
  }
}
