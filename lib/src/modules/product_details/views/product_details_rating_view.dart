import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/public/components.dart';
import '../../../resources/local/user_local.dart';
import '../../../routes/app_pages.dart';
import '../controllers/product_details_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_decorations.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../models/product_model.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../widgets/product_details.dart';

class ProductDetailsRatingView extends StatefulWidget {
  const ProductDetailsRatingView({super.key});

  @override
  State<ProductDetailsRatingView> createState() =>
      _ProductDetailsRatingViewState();
}

class _ProductDetailsRatingViewState extends State<ProductDetailsRatingView> {
  double _currPageValue = 0.0;
  PageController pageController = PageController();
  final double _height = SizerUtil.height / 2.64;
  final double _ratingProductImgSize = SizerUtil.height / 2.41;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    AppGet.productDetailsGet.clearMyRating();
    AppGet.productDetailsGet.avgRating.value = 0;
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsController productDetailsController =
        AppGet.productDetailsGet;
    ProductModel product = Get.arguments['product'];
    productDetailsController.ratings = Get.arguments['ratings'];

    productDetailsController.initProduct(product, AppGet.CartGet);
    double totalRating = 0;
    for (int i = 0; i < productDetailsController.ratings.length; i++) {
      totalRating += productDetailsController.ratings[i].rating;
      if (AppGet.authGet.onAuthCheck()) {
        if (productDetailsController.ratings[i].userId ==
            UserLocal().getUserId()) {
          productDetailsController
              .saveMyRating(productDetailsController.ratings[i].rating);
        }
      }
    }

    if (totalRating != 0) {
      productDetailsController.avgRating.value =
          totalRating / productDetailsController.ratings.length;
    }
    return Scaffold(
      body: Stack(
        children: [
          product.images.length > 1
              ? Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: _height,
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
                    height: _ratingProductImgSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(product.images[0]),
                      ),
                    ),
                  ),
                ),
          Positioned(
              top: 30.sp,
              left: 20.sp,
              right: 20.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    onTap: () => AppNavigator.pop(),
                    icon: Icons.clear,
                  ),
                  GetBuilder<ProductDetailsController>(
                    builder: (controller) => Stack(
                      children: [
                        AppIcon(
                          onTap: () {
                            if (controller.totalItems != 0) {
                              AppNavigator.push(AppRoutes.CART);
                            }
                          },
                          icon: Icons.shopping_cart_outlined,
                        ),
                        controller.totalItems != 0
                            ? Positioned(
                                right: 0.0,
                                top: 0.0,
                                child: CircleAvatar(
                                  radius: 7.sp,
                                  backgroundColor: colorPrimary,
                                  child: Text(
                                    productDetailsController.totalItems
                                        .toString(),
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )),
          productDetailsController.avgRating.value != 0.0
              ? Positioned(
                  top: _ratingProductImgSize - 80.sp,
                  right: 10.sp,
                  child: Obx(
                    () => Components.customRating(
                      productDetailsController.avgRating.value.toString(),
                    ),
                  ),
                )
              : Container(),

          product.images.length > 1
              ? Positioned(
                  top: _ratingProductImgSize - 80.sp,
                  right: 0.0,
                  left: 0.0,
                  child: DotsIndicator(
                    dotsCount:
                        product.images.isEmpty ? 1 : product.images.length,
                    position: _currPageValue.toInt(),
                    decorator: DotsDecorator(
                      activeColor: colorBranch,
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
            top: _ratingProductImgSize - 50.sp,
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(
                top: 20.sp,
                left: 20.sp,
                right: 20.sp,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.sp),
                  topRight: Radius.circular(20.sp),
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
                    oldPrice: product.oldPrice!,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Introduce'),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ExpandableTextWidget(
                        text: product.description,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppGet.authGet.onAuthCheck()
              ? RatingBar.builder(
                  itemSize: 20.sp,
                  initialRating: productDetailsController.getMyRating(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => Icon(
                        PhosphorIcons.starFill,
                        color: colorStar,
                      ),
                  onRatingUpdate: (rating) {
                    productDetailsController.saveMyRating(rating);
                    // productDetailsController.avgRating.value =
                    //     totalRating + rating / productDetailsController.ratings.length;
                    productDetailsController.rateProduct(
                      productId: product.id ?? "",
                      rating: rating,
                    );
                  })
              : Container(),
          SizedBox(height: 10.sp),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                  vertical: 20.sp,
                ),
                decoration:
                    AppDecoration.bottomNavigationBar(context).decoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 20.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Get.isDarkMode ? mCM : mCL,
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            InkWell(
                              onTap: () {
                                productDetailsController.setQuantity(
                                  false,
                                  product.quantity,
                                );
                              },
                              child: Icon(
                                Icons.remove,
                                color: fCL,
                              ),
                            ),
                            SizedBox(width: 5.sp),
                            Text(
                              productDetailsController.quantity.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(width: 5.sp),
                            InkWell(
                              onTap: () {
                                productDetailsController.setQuantity(
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
                      onTap: () => productDetailsController.addItem(product),
                    ),
                  ],
                ),
              ),
            ],
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
            height: _height,
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
