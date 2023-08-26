import '../controllers/edit_product_controller.dart';
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
import '../../navigator/controllers/navigator_admin_controller.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  double _currPageValue = 0;
  PageController pageController = PageController();
  final double _height = Dimensions.pageView;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    EditProductController editProductController = Get.find<EditProductController>();
    
    ProductModel product = Get.arguments['product'];

    editProductController.productNameUC.text = product.name;
    editProductController.descreptionUC.text = product.description;
    editProductController.priceUC.text = product.price.toString();
    editProductController.quantityUC.text = product.quantity.toString();

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: AppIcon(
              onTap: () => Get.back(),
              icon: Icons.clear,
            ),
            pinned: true, // expanded حتى يبقى الابار ظاهر حتى بعد ال
            backgroundColor: mC,
            expandedHeight: 315,
            flexibleSpace: FlexibleSpaceBar(
              background: product.images.length > 1
                  ? Container(
                      height: Dimensions.pageView,
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: pageController,
                        itemCount: product.images.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(
                            position,
                            product.images[position],
                          );
                        },
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      height: Dimensions.ratingProductImgSize,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.images[0]),
                        ),
                      ),
                    ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Dimensions.height10 * 7,
                      ),
                      // product.images.length > 1
                      //     ? DotsIndicator(
                      //         dotsCount: product.images.isEmpty
                      //             ? 1
                      //             : product.images.length,
                      //         position: _currPageValue.toInt(),
                      //         decorator: DotsDecorator(
                      //           activeColor: Colors.blue,
                      //           size: const Size.square(9.0),
                      //           activeSize: const Size(18.0, 9.0),
                      //           activeShape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(5.0)),
                      //         ),
                      //       )
                      //     : Container(),
                    ],
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? colorBlack : mC,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                    child: Center(
                        child: Text(
                          product.name,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 20.sp),
                        )),
                  ),
                ],
              ),
            ),
          ),
          // SliverAppBar(
          //   automaticallyImplyLeading: false,
          //   toolbarHeight: 70,
          //   title: AppIcon(
          //     onTap: () => Get.back(),
          //     icon: Icons.clear,
          //     backgroundColor: colorMedium,
          //   ),
          //   bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(20),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Container(
          //           width: double.maxFinite,
          //           padding: const EdgeInsets.only(
          //             top: 5,
          //             bottom: 10,
          //           ),
          //           decoration: BoxDecoration(
          //             color: Colors.grey[100],
          //             borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(Dimensions.radius20),
          //               topRight: Radius.circular(Dimensions.radius20),
          //             ),
          //           ),
          //           child: Center(
          //               child: Padding(
          //             padding: EdgeInsets.only(
          //               left: Dimensions.width20,
          //               right: Dimensions.width20,
          //             ),
          //             child: BigText(
          //               size: Dimensions.font26,
          //               text: 'Modify product',
          //               overflow: TextOverflow.clip,
          //             ),
          //           )),
          //         ),
          //       ],
          //     ),
          //   ),
          //   pinned: true, // expanded حتى يبقى الابار ظاهر حتى بعد ال
          //   backgroundColor: colorMedium,
          //   expandedHeight: 300.sp,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Image.network(
          //       product.images[0],
          //       width: double.maxFinite,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
              ),
              color: Get.isDarkMode ? colorBlack : mC,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.height20),
                  Text(
                    'Product Name',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: editProductController.productNameUC,
                    hintText: 'Product Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: Dimensions.height20),
                  Text(
                    'Product Descreption',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: editProductController.descreptionUC,
                    hintText: 'Product Descreption',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: Dimensions.height20),
                  Text(
                    'Product Price',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: editProductController.priceUC,
                    hintText: 'Product Price',
                    icon: Icons.price_change,
                  ),
                  SizedBox(height: Dimensions.height20),
                  Text(
                    'Product Quantity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: editProductController.quantityUC,
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
          GetBuilder<EditProductController>(builder: (editProductController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
                vertical: Dimensions.height20,
              ),
              decoration: AppDecoration.bottomNavigationBar(context).decoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextButton(
                    txt: 'Delete',
                    backgroundColor: colorHigh,
                    onTap: () {
                      Components.showCustomDialog(
                        context: context,
                        msg: 'Are you sure to delete the product ?',
                        ok: () {
                          editProductController.deleteProduct(
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
                        okColor: colorHigh,
                      );
                    },
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Text('OR', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  AppTextButton(
                    txt: 'Save Modific',
                    onTap: () {
                      editProductController.updateProduct(
                        id: product.id!,
                        name: editProductController.productNameUC.text,
                        description: editProductController.descreptionUC.text,
                        price: int.parse(editProductController.priceUC.text),
                        quantity: int.parse(editProductController.quantityUC.text),
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

  Widget _buildPageItem(
    int index,
    String image,
  ) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
          0,
          _height * (1 - _scaleFactor) / 2,
          1,
        );
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageView,
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
