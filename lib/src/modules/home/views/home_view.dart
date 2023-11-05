import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/core/widgets/icon_text_widget.dart';
import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/themes/font_family.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../themes/app_decorations.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_loader.dart';
import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';
import '../widgets/product_details_home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = SizerUtil.height / 3.84;
  HomeController homeController = AppGet.homeGet;

  Future<void> _loadResources() async {
    homeController.fetchProductsMostRecent();
    homeController.fetchProductsTopRest();
  }

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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.customAppBarHome(context),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return homeController.ProductsTopRest.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  await _loadResources();
                },
                color: colorPrimary,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.sp),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5.sp,
                        ),
                        child: ListTile(
                          title: AppText('Top Restaurants'),
                          subtitle: AppText(
                            'Ordered by Nearby first',
                            type: TextType.small,
                          ),
                          leading: Icon(Icons.stars_rounded),
                        ),
                      ),
                      // slider section
                      GetBuilder<HomeController>(
                        builder: (homeController) {
                          return SizedBox(
                            height: SizerUtil.height / 2.64,
                            child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: pageController,
                              itemCount: homeController.ProductsTopRest.length,
                              itemBuilder: (context, position) {
                                return _buildPageItem(
                                  position,
                                  homeController.ProductsTopRest[position],
                                );
                              },
                            ),
                          );
                        },
                      ),
                      //dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetBuilder<HomeController>(
                              builder: (popularProducts) {
                            return DotsIndicator(
                              dotsCount: homeController.ProductsTopRest.isEmpty
                                  ? 1
                                  : homeController.ProductsTopRest.length,
                              position: _currPageValue.toInt(),
                              decorator: DotsDecorator(
                                activeColor: colorPrimary,
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            );
                          }),
                        ],
                      ),
                      // Most Popular
                      SizedBox(height: 20.sp),
                      Padding(
                        padding: EdgeInsets.only(
                          // left: 15.sp,
                          bottom: 5.sp,
                        ),
                        child: ListTile(
                          title: AppText('Most Popular'),
                          subtitle: AppText(
                            'Ordered by Nearby first',
                            type: TextType.small,
                          ),
                          leading: Icon(
                            Icons.bubble_chart_sharp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120.sp,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: homeController.ProductsMostPopular.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 8.sp),
                          itemBuilder: (context, index) {
                            ProductModel product =
                                homeController.ProductsMostPopular[index];

                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: GestureDetector(
                                        onTap: () => AppNavigator.push(
                                          AppRoutes.DETAILS_PRODUCT_NEWEST,
                                          arguments: {
                                            'product': product,
                                            'ratings': product.ratings,
                                          },
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5.sp),
                                          decoration:
                                              AppDecoration.productFavoriteCart(
                                                      context, 15.sp)
                                                  .decoration,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 90.sp,
                                                height: 90.sp,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.sp),
                                                  color: index.isEven
                                                      ? const Color(0xFF69c5df)
                                                      : const Color(0xFF9294cc),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        product.images[0]),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.sp),
                                              SizedBox(
                                                width: 140.sp,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        AppText(product.name),
                                                        GetBuilder<
                                                                HomeController>(
                                                            builder:
                                                                (homeController) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        5.sp),
                                                            child: InkWell(
                                                              onTap: () {
                                                                if (homeController
                                                                            .isFavorite[
                                                                        product
                                                                            .id] ==
                                                                    1) {
                                                                  homeController
                                                                      .setFavorite(
                                                                          product
                                                                              .id,
                                                                          0);
                                                                  homeController
                                                                      .changeMealFavorite(
                                                                          product
                                                                              .id!);
                                                                } else {
                                                                  homeController
                                                                      .setFavorite(
                                                                          product
                                                                              .id,
                                                                          1);
                                                                  homeController
                                                                      .changeMealFavorite(
                                                                          product
                                                                              .id!);
                                                                }
                                                              },
                                                              child: Icon(
                                                                homeController.isFavorite[product
                                                                            .id] ==
                                                                        1
                                                                    ? Icons
                                                                        .favorite_outlined
                                                                    : Icons
                                                                        .favorite_border_outlined,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                    AppText(
                                                      product.category,
                                                      type: TextType.medium,
                                                    ),
                                                    SizedBox(height: 5.sp),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        IconAndTextWidget(
                                                          icon:
                                                              Icons.location_on,
                                                          text: '1.7KM',
                                                          iconColor:
                                                              colorPrimary,
                                                        ),
                                                        SizedBox(width: 10.sp),
                                                        IconAndTextWidget(
                                                          icon: Icons
                                                              .access_time_rounded,
                                                          text:
                                                              '${product.time.toString()}min',
                                                          iconColor: Colors.redAccent,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5.sp),
                                                    _ratingWidget(product),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    product.discount != 0
                                        ? Container(
                                            padding: EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.sp),
                                                bottomRight:
                                                    Radius.circular(15.sp),
                                              ),
                                              gradient: LinearGradient(
                                                colors: [
                                                  colorBranch.withOpacity(0.5),
                                                  colorStar.withOpacity(0.5),
                                                ],
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                              ),
                                            ),
                                            child: Text(
                                              '%${product.discount!.toString()}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: FontFamily.lato,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.sp),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5.sp,
                        ),
                        child: ListTile(
                          title: AppText('Most Recent'),
                          subtitle: AppText(
                            'Be the first to do so',
                            type: TextType.small,
                          ),
                          leading: Icon(
                            Icons.history,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeController.ProductsMostRecent.length,
                        padding: EdgeInsets.all(5.sp),
                        itemBuilder: (BuildContext context, int index) {
                          ProductModel product =
                              homeController.ProductsMostRecent[index];
                          return GestureDetector(
                            onTap: () => AppNavigator.push(
                              AppRoutes.DETAILS_PRODUCT_NEWEST,
                              arguments: {
                                'product': product,
                                'ratings': product.ratings,
                              },
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 160.sp,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.sp),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            product.images[0],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.sp),
                                Text(
                                  product.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 20.sp),
                                ),
                                SizedBox(height: 8.sp),
                                AppText(product.category),
                                SizedBox(height: 5.sp),
                                _ratingWidget(product),
                                SizedBox(height: 5.sp),
                                Divider(),
                                SizedBox(height: 10.sp),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : CustomLoader();
      }),
    );
  }

  Widget _buildPageItem(
    int index,
    ProductModel product,
  ) {
    double totalRating = 0;
    double avgRating = 0;

    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }

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
    return GestureDetector(
      onTap: () {
        AppNavigator.push(
          AppRoutes.DETAILS_PRODUCT_RATING,
          arguments: {
            'product': product,
            'ratings': product.ratings,
          },
        );
      },
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: _height,
              margin: EdgeInsets.only(
                left: 10.sp,
                right: 10.sp,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.images[0]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  avgRating != 0.0
                      ? Padding(
                          padding: EdgeInsets.only(
                            right: 20.sp,
                            bottom: 8.sp,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                              5.sp,
                            ),
                            decoration: BoxDecoration(
                              color: colorStar,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: colorBlack,
                                  size: 15.sp,
                                ),
                                Text(
                                  avgRating.toString(),
                                  style: TextStyle(
                                    color: colorBlack,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20.sp,
                      right: 20.sp,
                      bottom: 30.sp,
                    ),
                    decoration:
                        AppDecoration.productFavoriteCart(context, 20.sp)
                            .decoration,
                    child: Container(
                      padding: EdgeInsets.all(
                        10.sp,
                      ),
                      child: ProductDetailsHome(
                        product: product,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _iconWidget(bool isTotalRating) {
    return Icon(
      Icons.star,
      color: isTotalRating ? colorStar : Colors.grey,
      size: 15.sp,
    );
  }

  Widget _ratingWidget(ProductModel product) {
    double totalRating = 0;

    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].rating;
    }

    return Row(
      children: [
        _iconWidget(totalRating >= 1.0),
        _iconWidget(totalRating >= 2.0),
        _iconWidget(totalRating >= 3.0),
        _iconWidget(totalRating >= 4.0),
        _iconWidget(totalRating == 5),
        SizedBox(width: 3.sp),
        product.ratings!.length > 1
            ? Expanded(
                child: AppText(
                  '${product.ratings!.length} Review',
                  type: TextType.medium,
                ),
              )
            : Container(),
      ],
    );
  }
}
