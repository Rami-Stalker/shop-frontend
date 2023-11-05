import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../public/components.dart';
import '../../../resources/local/user_local.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_decorations.dart';
import '../controllers/product_details_controller.dart';
import '../../../themes/app_colors.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../models/product_model.dart';
import '../../../utils/sizer_custom/sizer.dart';

class ProductDetailsNewestView extends StatefulWidget {
  const ProductDetailsNewestView({super.key});

  @override
  State<ProductDetailsNewestView> createState() =>
      _ProductDetailsNewestViewState();
}

class _ProductDetailsNewestViewState extends State<ProductDetailsNewestView> {
  double _currPageValue = 0.0;
  PageController pageController = PageController();
  final double _height = 340;
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

    if (UserLocal().getUser()!.favorites!.contains(product.id)) {
      productDetailsController.isFavorite.value = true;
    } else {
      productDetailsController.isFavorite.value = false;
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50.sp,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => AppNavigator.pop(),
                  icon: Icons.clear,
                ),
                GetBuilder<ProductDetailsController>(
                  builder: (productDetailsController) => Stack(
                    children: [
                      AppIcon(
                        onTap: () {
                          if (productDetailsController.totalItems != 0) {
                            AppNavigator.push(AppRoutes.CART);
                          }
                        },
                        icon: Icons.shopping_cart_outlined,
                      ),
                      productDetailsController.totalItems != 0
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
                      productDetailsController.totalItems != 0
                          ? Positioned(
                              right: 3.0,
                              top: 3.0,
                              child: AppText(
                                productDetailsController.totalItems.toString(),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            pinned: true,
            backgroundColor: colorBranch,
            expandedHeight: 220.sp,
            flexibleSpace: FlexibleSpaceBar(
              background: product.images.length > 1
                  ? Stack(
                      children: [
                        Container(
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
                        Positioned(
                            top: _height - 60,
                            left: 0,
                            right: 0,
                            child: DotsIndicator(
                              dotsCount: product.images.isEmpty
                                  ? 1
                                  : product.images.length,
                              position: _currPageValue.toInt(),
                              decorator: DotsDecorator(
                                activeColor: colorBranch,
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            )),
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
              preferredSize: const Size.fromHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      product.images.length > 1
                          ? DotsIndicator(
                              dotsCount: product.images.isEmpty
                                  ? 1
                                  : product.images.length,
                              position: _currPageValue.toInt(),
                              decorator: DotsDecorator(
                                activeColor: colorBranch,
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            )
                          : Container(),
                      productDetailsController.avgRating.value != 0.0
                          ? Obx(
                              () => Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: Components.customRating(
                                  productDetailsController.avgRating.value
                                      .toString(),
                                ),
                              ),
                            )
                          : SizedBox(width: 70.sp),
                    ],
                  ),
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
                    )),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
              ),
              child: ExpandableTextWidget(
                text: product.description,
              ),
            ),
          ),
        ],
      ),
      //bottom
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
                    productDetailsController.rateProduct(
                      productId: product.id ?? "",
                      rating: rating,
                    );
                  })
              : Container(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40.sp,
              vertical: 10.sp,
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      onTap: () {
                        productDetailsController.setQuantity(
                          false,
                          product.quantity,
                        );
                      },
                      iconSize: 24.sp,
                      iconColor: mCL,
                      backgroundColor: colorPrimary,
                      icon: Icons.remove,
                    ),
                    AppText(
                        '\$${product.price} *  ${productDetailsController.quantity.value} '),
                    AppIcon(
                      onTap: () {
                        productDetailsController.setQuantity(
                          true,
                          product.quantity,
                        );
                      },
                      iconSize: 24.sp,
                      iconColor: mCL,
                      backgroundColor: colorPrimary,
                      icon: Icons.add,
                    ),
                  ],
                )),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                  vertical: 30.sp,
                ),
                decoration:
                    AppDecoration.bottomNavigationBar(context).decoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<ProductDetailsController>(
                        builder: (productDetailsController) {
                      return Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Get.isDarkMode ? mCM : mCL,
                        ),
                        child: InkWell(
                          onTap: () {
                            productDetailsController.setFavorite();
                            productDetailsController
                                .changeMealFavorite(product.id!);
                          },
                          child: Icon(
                            productDetailsController.isFavorite.value
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }),
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
      child: Container(
        height: _height,
        decoration: BoxDecoration(
          color:
              index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}
