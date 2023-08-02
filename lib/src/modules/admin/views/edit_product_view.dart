import 'package:shop_app/src/modules/admin/controllers/admin_controller.dart';

import '../../../core/utils/components/app_components.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../models/product_model.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../../navigator/controllers/navigator_admin_controller.dart';

class EditProductView extends GetView<AdminController> {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.arguments['product'];

    controller.productNameUC.text = product.name;
    controller.descreptionUC.text = product.description;
    controller.priceUC.text = product.price.toString();
    controller.quantityUC.text = product.quantity.toString();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      //body
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: AppIcon(
              onTap: () => Get.back(),
              icon: Icons.clear,
              backgroundColor: AppColors.originColor,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(
                        size: Dimensions.font26,
                        text: ' Modify product',
                        overflow: TextOverflow.clip,
                      ),
                    )),
                  ),
                ],
              ),
            ),
            pinned: true, // expanded حتى يبقى الابار ظاهر حتى بعد ال
            backgroundColor: AppColors.originColor,
            expandedHeight: 300.sp,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.images[0],
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Name',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.productNameUC,
                    hintText: 'Product Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Descreption',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.descreptionUC,
                    hintText: 'Product Descreption',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Price',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.priceUC,
                    hintText: 'Product Price',
                    icon: Icons.price_change,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Quantity',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.quantityUC,
                    hintText: 'Product Quantity',
                    icon: Icons.production_quantity_limits,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //bottom
      bottomNavigationBar:
          GetBuilder<AdminController>(builder: (adminController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                right: Dimensions.width20,
                left: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.sp),
                  topRight: Radius.circular(40.sp),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<AdminController>(builder: (adminController) {
                    return GestureDetector(
                      onTap: () {
                        AppComponents.showCustomDialog(
                          context: context,
                          msg: 'Are you sure to delete the product ?',
                          ok: () {
                            adminController.deleteProduct(
                              product: product,
                              // onSuccess: () {
                              //   controller.products.removeAt(index);
                              //   Get.toNamed(Routes.ADMIN_NAVIGATOR);
                              // },
                            );
                            Get.find<NavigatorAdminController>()
                                .currentIndex
                                .value = 0;
                          },
                          okColor: Colors.red,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width10 * 4,
                          right: Dimensions.width10 * 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }),
                  AppTextButton(
                    txt: 'Save modifications',
                    onTap: () {
                      adminController.updateProduct(
                        id: product.id!,
                        name: controller.productNameUC.text,
                        description: controller.descreptionUC.text,
                        price: int.parse(controller.priceUC.text),
                        quantity: int.parse(controller.quantityUC.text),
                      );
                      Get.find<NavigatorAdminController>().currentIndex.value =
                          0;
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
