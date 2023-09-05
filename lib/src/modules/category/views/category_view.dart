import '../../../controller/app_controller.dart';
import '../../../core/widgets/product_widget.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/no_data_page.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../controllers/category_controller.dart';

class CatigoryView extends GetView<CategoryController> {
  const CatigoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title:
            Text(Get.arguments, style: Theme.of(context).textTheme.titleLarge),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: AppIcon(
            onTap: () => AppNavigator.pop(),
            icon: Icons.arrow_back_ios,
            backgroundColor: colorMedium,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<List<ProductModel>?>(
              future: controller.fetchCategoryProduct(category: Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        
                        itemCount: controller.productCategory?.length ?? 0,
                        itemBuilder: (context, index) {
                          var product = controller.productCategory![index];
                          return ProductWidget(
                            onTap: () {
                              if (AppGet.authGet.userModel!.type == 'admin') {
                    AppNavigator.push(
                      Routes.PRODUCT_EDIT,
                      arguments: {
                        'product': product,
                        'ratings': product.rating,
                      },
                    );
                  } else {
                    AppNavigator.push(
                      Routes.PRODUCT_DETAILS_RATING,
                      arguments: {
                        'product': product,
                        'ratings': product.rating,
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
                      imgPath: Constants.EMPTY_ASSET,
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
