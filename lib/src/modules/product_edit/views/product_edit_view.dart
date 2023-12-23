import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop_app/src/core/dialogs/dialog_loading.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';

import '../../../routes/app_pages.dart';
import '../controllers/product_edit_controller.dart';
import '../../../themes/app_colors.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../models/product_model.dart';
import '../../../themes/app_decorations.dart';
import '../../../utils/sizer_custom/sizer.dart';

class ProductEditView extends GetView<ProductEditController> {
  const ProductEditView({super.key});

//   @override
//   State<ProductEditView> createState() => _ProductEditViewState();
// }

// class _ProductEditViewState extends State<ProductEditView> {
  // double _currPageValue = 0;
  // PageController pageController = PageController();
  // final double _height = 340;
  // final double _scaleFactor = 0.8;

  // @override
  // void initState() {
  //   super.initState();
  //   pageController.addListener(() {
  //     setState(() {
  //       _currPageValue = pageController.page!;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    
    ProductModel product = controller.product;

    // _productNameController.text = product.name;
    // _descreptionController.text = product.description;
    // _priceController.text = product.price.toString();
    // _discountController.text = product.discount.toString();
    // _quantityController.text = product.quantity.toString();

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50.sp,
            title: AppIcon(
              onTap: () => AppNavigator.pop(),
              icon: Icons.clear,
            ),
            pinned: true,
            backgroundColor: colorPrimary,
            expandedHeight: 220.sp,
            flexibleSpace: FlexibleSpaceBar(
              background: product.images.length > 1
                  ? Stack(
                      children: [
                        Container(
                          height: controller.height,
                          color: Colors.grey[100],
                          child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: controller.pageController,
                            itemCount: product.images.length,
                            itemBuilder: (context, position) {
                              return _buildPageItem(
                                position,
                                product.images[position],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: double.maxFinite,
                      height: SizerUtil.height / 2.41,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.images[0]),
                        ),
                      ),
                    ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  product.images.length > 1
                      ? DotsIndicator(
                          dotsCount: product.images.isEmpty
                              ? 1
                              : product.images.length,
                          position: controller.currPageValue.toInt(),
                          decorator: DotsDecorator(
                            activeColor: colorBranch,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10.sp),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5.sp),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? colorBlack : mC,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp),
                      ),
                    ),
                    child: Center(
                      child: AppText(
                        product.name,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
              ),
              color: Get.isDarkMode ? colorBlack : mC,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.sp),
                  AppText('Product Name'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    textController: controller.productNameController,
                    hintText: 'Product Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Descreption'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    textController: controller.descreptionController,
                    hintText: 'Product Descreption',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Price'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    textController: controller.priceController,
                    hintText: 'Product Price',
                    icon: Icons.price_change,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Discount'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    textController: controller.discountController,
                    hintText: 'Product Discount',
                    icon: Icons.discount,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Quantity'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    textController: controller.quantityController,
                    hintText: 'Product Quantity',
                    icon: Icons.production_quantity_limits,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Time'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    textController: controller.timeController,
                    hintText: 'Product Time',
                    icon: Icons.timelapse,
                  ),
                  SizedBox(height: 10.sp),
                ],
              ),
            ),
          ),
        ],
      ),
      //bottom
      bottomNavigationBar:
          GetBuilder<ProductEditController>(builder: (editProductController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
                vertical: 20.sp,
              ),
              decoration: AppDecoration.bottomNavigationBar(context).decoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextButton(
                    txt: 'Delete',
                    backgroundColor: colorError,
                    onTap: () {
                      Components.showCustomDialog(
                        context: context,
                        msg: 'Are you sure to delete the product ?',
                        ok: () {
                          editProductController.deleteProduct(
                            product: product,
                          );
                        },
                        okColor: colorError,
                      );
                    },
                  ),
                  SizedBox(width: 10.sp),
                  AppText('OR'),
                  SizedBox(width: 10.sp),
                  AppTextButton(
                    txt: 'Save Modific',
                    onTap: () {
                      showDialogLoading(context);
                      editProductController.productEdit(
                        id: product.id!,
                        name: controller.productNameController.text,
                        description: controller.descreptionController.text,
                        price: int.parse(controller.priceController.text),
                        quantity: int.parse(controller.quantityController.text),
                      );
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

  Widget _buildPageItem(
    int index,
    String image,
  ) {
    Matrix4 matrix = Matrix4.identity();
    if (index == controller.currPageValue.floor()) {
      var currScale = 1 - (controller.currPageValue - index) * (1 - controller.scaleFactor);
      var currtrans = controller.height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == controller.currPageValue.floor() + 1) {
      var currScale =
          controller.scaleFactor + (controller.currPageValue - index + 1) * (1 - controller.scaleFactor);
      var currtrans = controller.height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == controller.currPageValue.floor() - 1) {
      var currScale = 1 - (controller.currPageValue - index) * (1 - controller.scaleFactor);
      var currtrans = controller.height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
          0,
          controller.height * (1 - controller.scaleFactor) / 2,
          1,
        );
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: controller.height,
            decoration: BoxDecoration(
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
