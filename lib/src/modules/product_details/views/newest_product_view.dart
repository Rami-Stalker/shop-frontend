import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';
import '../../../themes/app_colors.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../models/product_model.dart';
import '../../../models/rating_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/sizer_custom/sizer.dart';

class NewestProductView extends StatefulWidget {
  const NewestProductView({super.key});

  @override
  State<NewestProductView> createState() => _NewestProductViewState();
}

class _NewestProductViewState extends State<NewestProductView> {
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
    ProductDetailsController productDetailsController =
        Get.find<ProductDetailsController>();
    ProductModel product = Get.arguments['product'];
    List<RatingModel> ratings = Get.arguments['ratings'];
    productDetailsController.initProduct(product, Get.find<CartController>());
    double totalRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      totalRating += ratings[i].rating;
      if (ratings[i].userId == AppGet.authGet.userModel!.id) {
        productDetailsController.myRating.value = ratings[i].rating;
      }
    }

    if (totalRating != 0) {
      productDetailsController.avgRating.value = totalRating / ratings.length;
    }
    return Scaffold(
      //body
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                              right: 3.0,
                              top: 3.0,
                              child: BigText(
                                text: Get.find<ProductDetailsController>()
                                    .totalItems
                                    .toString(),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            pinned: true, // expanded حتى يبقى الابار ظاهر حتى بعد ال
            backgroundColor: colorMedium,
            expandedHeight: 315,
            flexibleSpace: FlexibleSpaceBar(
              background: product.images.length > 1
                  ? Container(
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
                      Container(
                        width: Dimensions.height10 * 7,
                      ),
                      product.images.length > 1
                          ? DotsIndicator(
                              dotsCount: product.images.isEmpty
                                  ? 1
                                  : product.images.length,
                              position: _currPageValue.toInt(),
                              decorator: DotsDecorator(
                                activeColor: Colors.blue,
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            )
                          : Container(),
                      productDetailsController.avgRating.value != 0.0
                          ? Obx(() {
                              return Padding(
                                padding: EdgeInsets.all(Dimensions.height10),
                                child: Container(
                                  padding: EdgeInsets.all(
                                    Dimensions.width10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorStar,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: const Offset(0, 2),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        PhosphorIcons.star,
                                      ),
                                      Text(
                                        productDetailsController.avgRating.value
                                            .toString(),
                                        style: TextStyle(
                                          color: colorBlack,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                          : Container(
                              width: Dimensions.height10 * 7,
                            ),
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
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                      ),
                      child: Text(
                        product.name,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 20.sp),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
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
                  PhosphorIcons.star,
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
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40.sp,
              vertical: Dimensions.height10,
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
                      iconSize: Dimensions.iconSize24,
                      iconColor: mCL,
                      backgroundColor: colorPrimary,
                      icon: Icons.remove,
                    ),
                    Text(
                      '\$${product.price} *  ${productDetailsController.quantity.value} ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    AppIcon(
                      onTap: () {
                        productDetailsController.setQuantity(
                          true,
                          product.quantity,
                        );
                      },
                      iconSize: Dimensions.iconSize24,
                      iconColor: mCL,
                      backgroundColor: colorPrimary,
                      icon: Icons.add,
                    ),
                  ],
                )),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
              vertical: Dimensions.height30,
            ),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? fCD : mCD,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius45),
                topRight: Radius.circular(Dimensions.radius45),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Get.isDarkMode ? mCM : mCL,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.grey,
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
