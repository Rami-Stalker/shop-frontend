import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/public/components.dart';
import '../controllers/home_controller.dart';
import '../../../themes/app_decorations.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/category_widget.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../models/product_model.dart';
import '../../../routes/app_pages.dart';
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
    homeController.fetchNewestProduct();
    homeController.fetchRatingProduct();
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
        return homeController.productRating.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  await _loadResources();
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.sp),
                      const CategoryWidget(),
                      SizedBox(height: 20.sp),
                      AppText('title medium'),
                      AppText('title medium', type: TextType.medium),
                      AppText('title medium', type: TextType.small),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30.sp,
                          bottom: 15.sp,
                        ),
                        child: AppText('Highest Rated'),
                      ),
                      // slider section
                      GetBuilder<HomeController>(builder: (homeController) {
                        return SizedBox(
                          height: SizerUtil.height / 2.64,
                          child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: pageController,
                            itemCount: homeController.productRating.length,
                            itemBuilder: (context, position) {
                              return _buildPageItem(
                                position,
                                homeController.productRating[position],
                              );
                            },
                          ),
                        );
                      }),
                      //dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetBuilder<HomeController>(
                              builder: (popularProducts) {
                            return DotsIndicator(
                              dotsCount: homeController.productRating.isEmpty
                                  ? 1
                                  : homeController.productRating.length,
                              position: _currPageValue.toInt(),
                              decorator: DotsDecorator(
                                activeColor: Colors.blue,
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            );
                          }),
                        ],
                      ),

                      //Popular text
                      SizedBox(height: 20.sp),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30.sp,
                          bottom: 15.sp,
                        ),
                        child: AppText('Newest Products'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.sp,
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.6,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: homeController.productNewest.length,
                          itemBuilder: (context, index) {
                            var product = homeController.productNewest[index];
                            double totalRating = 0;
                            double avgRating = 0;
                            for (int i = 0; i < product.rating!.length; i++) {
                              totalRating += product.rating![i].rating;
                            }
                            if (totalRating != 0) {
                              avgRating = totalRating / product.rating!.length;
                            }

                            double docs =
                                product.price / product.oldPrice * 100;
                            return product.quantity == 0
                                ? Container()
                                : GestureDetector(
                                    onTap: () => AppNavigator.push(
                                      Routes.PRODUCT_DETAILS_NEWEST,
                                      arguments: {
                                        'product': product,
                                        'ratings': product.rating,
                                      },
                                    ),
                                    child: Column(
                                      children: [
                                        //image section
                                        Expanded(
                                          flex: 5,
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                // width: double.infinity,
                                                // height: 120.sp,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      10.sp,
                                                    ),
                                                    topRight: Radius.circular(
                                                      10.sp,
                                                    ),
                                                  ),
                                                  color: index.isEven
                                                      ? const Color(0xFF69c5df)
                                                      : const Color(0xFF9294cc),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      product.images[0],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              product.oldPrice != 0
                                                  ? Positioned(
                                                      top: 0.0,
                                                      left: 0.0,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorPrimary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                              10.sp,
                                                            ),
                                                            topLeft:
                                                                Radius.circular(
                                                              20.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            AppText(
                                                                'Disc %${docs.round()}'),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              avgRating != 0.0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        5.0,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          5.sp,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorStar,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10.sp,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color: colorBlack,
                                                              size: 15.sp,
                                                            ),
                                                            Text(
                                                              avgRating
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    colorBlack,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: EdgeInsets.all(3.sp),
                                            decoration:
                                                AppDecoration.newestProduct(
                                              context,
                                              10.sp,
                                            ).decoration,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 100.sp,
                                                      child:
                                                          AppText(product.name),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.sp),
                                                Row(
                                                  children: [
                                                    AppText(
                                                        '\$${product.price.toString()}'),
                                                    const Spacer(),
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                        5.sp,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          15.sp,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.category,
                                                            color: colorBlack,
                                                            size: 15.sp,
                                                          ),
                                                          Text(
                                                            product.category,
                                                            style: TextStyle(
                                                              color: colorBlack,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
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

    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
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
          Routes.PRODUCT_DETAILS_RATING,
          arguments: {
            'product': product,
            'ratings': product.rating,
          },
        );
      },
      // Get.toNamed(
      //   Routes.PRODUCT_DETAILS_RATING,
      //   arguments: {
      //     'product': product,
      //     'ratings': product.rating,
      //   },
      // ),
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
                    decoration: AppDecoration.dots(context, 20.sp).decoration,
                    child: Container(
                      padding: EdgeInsets.all(
                        10.sp,
                      ),
                      child: ProductDetailsHome(
                        name: product.name,
                        category: product.category,
                        price: product.price,
                        oldPrice: product.oldPrice,
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
}
