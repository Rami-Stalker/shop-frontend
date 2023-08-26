import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_decorations.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../controller/user_controller.dart';
import '../../../models/product_model.dart';
import '../../../models/rating_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../widgets/product_details.dart';

class RatingProductView extends StatefulWidget {
  const RatingProductView({super.key});

  @override
  State<RatingProductView> createState() => _RatingProductViewState();
}

class _RatingProductViewState extends State<RatingProductView> {
  double _currPageValue = 0.0;
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
    ProductDetailsController productDetailsCtrl =
        Get.find<ProductDetailsController>();
    ProductModel product = Get.arguments['product'];
    List<RatingModel> ratings = Get.arguments['ratings'];
    productDetailsCtrl.initProduct(product, Get.find<CartController>());
    double totalRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      totalRating += ratings[i].rating;
      if (ratings[i].userId == Get.find<UserController>().user.id) {
        productDetailsCtrl.myRating.value = ratings[i].rating;
      }
    }

    if (totalRating != 0) {
      productDetailsCtrl.avgRating.value = totalRating / ratings.length;
    }

    return Scaffold(
      body: Stack(
        children: [
          product.images.length > 1
              ? Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: Dimensions.pageView,
                    color: Colors.grey[100],
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
                  ),
                )
              : Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Container(
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
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    onTap: () => Get.back(),
                    icon: Icons.clear,
                  ),
                  GetBuilder<ProductDetailsController>(
                    builder: (controller) => Stack(
                      children: [
                        AppIcon(
                          onTap: () {
                            if (controller.totalItems != 0) {
                              Get.toNamed(Routes.CART);
                            }
                          },
                          icon: Icons.shopping_cart_outlined,
                        ),
                        controller.totalItems != 0
                            ? Positioned(
                                right: 0.0,
                                top: 0.0,
                                child: AppIcon(
                                  onTap: () {},
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: colorPrimary,
                                ),
                              )
                            : Container(),
                        controller.totalItems != 0
                            ? Positioned(
                                right: 6.sp,
                                top: 1.sp,
                                child: 
                                Text(Get.find<ProductDetailsController>()
                                      .totalItems
                                      .toString(),
                                      style: Theme.of(context).textTheme.titleMedium,
                                      ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )),
          productDetailsCtrl.avgRating.value != 0.0
              ? Positioned(
                  top: 260.sp,
                  right: Dimensions.width20,
                  child: Obx(
                    () {
                      return Container(
                        padding: EdgeInsets.all(
                          Dimensions.width10,
                        ),
                        decoration: BoxDecoration(
                          color: colorStar,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                              color: mCM,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              PhosphorIcons.star,
                            ),
                            Text(
                              productDetailsCtrl.avgRating.value.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container(),

          product.images.length > 1
              ? Positioned(
                  top: 260.sp,
                  right: 0.0,
                  left: 0.0,
                  child: DotsIndicator(
                    dotsCount:
                        product.images.isEmpty ? 1 : product.images.length,
                    position: _currPageValue.toInt(),
                    decorator: DotsDecorator(
                      activeColor: Colors.blue,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                )
              : Container(),

          // body
          Positioned(
            top: Dimensions.ratingProductImgSize - 50,
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Get.isDarkMode ? colorBlack : mC,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailsWidget(
                    name: product.name,
                    category: product.category,
                    price: product.price,
                    oldPrice: product.oldPrice,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Text(
                    'Introduce',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ExpandableTextWidget(
                        text: product.description,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  GetBuilder<ProductDetailsController>(
                    builder: (productDetailsCtrl) {
                      return RatingBar.builder(
                        itemSize: 20.sp,
                        initialRating: productDetailsCtrl.myRating.value,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: colorStar,
                        ),
                        onRatingUpdate: (rating) {
                          // productDetailsCtrl.rateProduct(
                          //   product: product,
                          //   rating: rating,
                          // );
                        },
                      );
                    },
                  ),
                  SizedBox(height: Dimensions.height10),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
              vertical: Dimensions.height20,
            ),
            decoration: AppDecoration.bottomNavigationBar(context).decoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: Get.isDarkMode ? mCM : mCL,
                  ),
                  child: Obx(
                    () => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            productDetailsCtrl.setQuantity(
                              false,
                              product.quantity,
                            );
                          },
                          child: Icon(
                            Icons.remove,
                            color: fCL,
                          ),
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        Text(
                          productDetailsCtrl.quantity.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        InkWell(
                          onTap: () {
                            productDetailsCtrl.setQuantity(
                              true,
                              product.quantity,
                            );
                          },
                          child: Icon(
                            Icons.add,
                            color: fCL,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppTextButton(
                  txt: 'Add to Cart',
                  onTap: () => productDetailsCtrl.addItem(product),
                ),
              ],
            ),
          ),
        ],
      ),
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
              // borderRadius: BorderRadius.circular(Dimensions.radius15),
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
