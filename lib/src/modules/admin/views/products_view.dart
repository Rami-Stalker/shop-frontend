import 'package:get/get.dart';
import 'package:shop_app/src/controller/theme_controller.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import '../controllers/admin_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_decorations.dart';

import '../../../controller/notification_controller.dart';
import '../../../core/widgets/category_widget.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../core/widgets/product_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';
import '../../../models/product_model.dart';
import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/theme_service.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../widgets/build_shimmer_products.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  void navigateToAddProduct() {
    Get.toNamed(Routes.ADD_PRODUCT);
  }

  void navigateToSearchView() {
    Get.toNamed(Routes.SEARCH);
  }

  AdminController adminController = Get.find<AdminController>();

  Future<void> _loadResources() async {
    adminController.fetchAllProducts();
    await Get.find<NotificationController>().getNotofication();
  }

  @override
  void initState() {
    super.initState();
    // connectAndListen();
  }
  @override
  Widget build(BuildContext context) {
    // Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: GetBuilder<AuthController>(
          builder: (loginController) {
            return loginController.userModel!.address.isNotEmpty
                ? Container(
                    width: 200.sp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ramy App',
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: Dimensions.font26,
                          ),
                        ),
                        Text(
                          loginController.userModel!.address,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )
                : Text(
                    'Ramy App',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: colorPrimary,
                          fontSize: Dimensions.font26,
                        ),
                  );
          },
        ),
        actions: [
          FutureBuilder<List<NotificationModel>>(
            future: Get.find<NotificationController>().getNotofication(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int isSeen = 0;
                for (int i = 0; i < snapshot.data!.length; i++) {
                  if (snapshot.data![i].isSeen == false) {
                    isSeen += 1;
                  }
                }
                return Container(
                  padding: EdgeInsets.all(8.sp),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATION,
                          arguments: snapshot.data);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration:
                          AppDecoration.appbarIcon(context, 5.sp).decoration,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 20.sp,
                            color: colorPrimary,
                          ),
                          isSeen != 0
                              ? Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: CircleAvatar(
                                    radius: 5.sp,
                                    backgroundColor: mCL,
                                    child: CircleAvatar(
                                      radius: 4.sp,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container(
                padding: EdgeInsets.all(8.sp),
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration:
                      AppDecoration.appbarIcon(context, 5.sp).decoration,
                  child: Icon(
                    Icons.notifications,
                    size: 20.sp,
                    color: colorPrimary,
                  ),
                ),
              );
            },
          ),
          GetBuilder<ThemeController>(
            builder: (themeController) {
              return Container(
                padding: EdgeInsets.all(8.sp),
                child: GestureDetector(
                  onTap: () {
                    themeController.onChangeTheme(
                        ThemeService.currentTheme == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: AppDecoration.appbarIcon(context, 5.sp).decoration,
                    child: Icon(
                      Get.isDarkMode
                          ? Icons.wb_sunny_outlined
                          : Icons.nightlight_round_outlined,
                      size: 20.sp,
                      color: colorPrimary,
                    ),
                  ),
                ),
              );
            }
          ),
        ],
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.SEARCH),
              child: Container(
                width: Get.width,
                padding: EdgeInsets.all(Dimensions.height10),
                decoration: AppDecoration.textfeild(context, 5.sp).decoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search your desired food",
                      style: TextStyle(
                        color: mCH,
                      ),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              ),
            ),
          ),
          preferredSize: Size(
            Dimensions.screenWidth,
            50.sp,
          ),
        ),
      ),
      body: GetBuilder<AdminController>(builder: (adminC) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.height10),
              const CategoryWidget(),
              SizedBox(
                height: Dimensions.height20,
              ),
              FutureBuilder<List<ProductModel>>(
                  future: Get.find<AdminController>().fetchAllProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          var product = snapshot.data![index];
                          return ProductWidget(
                            onTap: () {
                              Get.toNamed(
                                Routes.EDIT_PRODUCT,
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
                        imgPath: Constants.EMPTY_ASSET,
                      );
                    }
                    return BuildShimmerProducts();
                  }),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        backgroundColor: colorPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
