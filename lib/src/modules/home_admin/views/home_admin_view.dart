import 'package:get/get.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../core/widgets/head_home_widget.dart';
import '../../../themes/app_colors.dart';
import '../controllers/home_admin_controller.dart';

import '../../../core/widgets/no_data_page.dart';
import '../../../core/widgets/product_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../../../core/widgets/custom_shimmer_products.dart';

class HomeAdminView extends StatefulWidget {
  const HomeAdminView({super.key});

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAdminController>(builder: (adminController) {
      return SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadHomeWidget(),
                  SizedBox(height: 10.sp),
                  FutureBuilder<List<ProductModel>>(
                      future: AppGet.adminGet.fetchAllProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              var product = snapshot.data![index];
                              return ProductWidget(
                                onTap: () {
                                  AppNavigator.push(
                                    AppRoutes.EDIT_PRODUCT,
                                    arguments: {
                                      'product': product,
                                    },
                                  );
                                },
                                product: product,
                                index: index,
                              );
                            },
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.none) {
                          return NoDataPage(
                            text: "Not found products yet",
                            imgPath: AppConstants.EMPTY_ASSET,
                          );
                        }
                        return CustomShimmerProducts();
                      }),
                ],
              ),
            ),
            Positioned(
              bottom: 10.sp,
              right: 10.sp,
              child: FloatingActionButton(
              onPressed: () => AppNavigator.push(AppRoutes.CREATE_PRODUCT),
              tooltip: 'Add a Product',
              backgroundColor: colorPrimary,
              child: const Icon(Icons.add),
            ),),
          ],
        ),
      );
    });
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () => AppNavigator.push(AppRoutes.CREATE_PRODUCT),
    //     tooltip: 'Add a Product',
    //     backgroundColor: colorPrimary,
    //     child: const Icon(Icons.add),
    //   ),
    // );
  }
}
