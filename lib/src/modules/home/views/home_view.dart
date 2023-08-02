import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop_app/src/controller/notification_controller.dart';
import 'package:shop_app/src/models/notification_model.dart';
import 'package:shop_app/src/modules/home/controllers/home_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_column.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/small_text.dart';
import '../../../models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../widgets/home_categories.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  HomeController homeController = Get.find<HomeController>();

  Future<void> _loadResources() async {
    homeController.fetchNewestProduct();
    homeController.fetchRatingProduct();
    await Get.find<NotificationController>().getNotofication();
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
    Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        title: GetBuilder<UserController>(
          builder: (userController) {
            return userController.user.address.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ramy App',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SmallText(
                        text: userController.user.address.length > 30
                            ? '${userController.user.address.substring(0, 30)}...'
                            : '',
                        color: Colors.black54,
                      ),
                    ],
                  )
                : Text(
                    'Ramy App',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
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
                    padding: EdgeInsets.all(5.sp),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.NOTIFICATION,
                            arguments: snapshot.data);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 20.sp,
                              color: AppColors.mainColor,
                            ),
                            isSeen != 0
                                ? Positioned(
                                    top: 0.0,
                                    right: 0.0,
                                    child: CircleAvatar(
                                      radius: 5.sp,
                                      backgroundColor: Colors.white,
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
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: Icon(
                    Icons.notifications,
                    size: 20.sp,
                    color: AppColors.mainColor,
                  ),
                );
              }),
        ],
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.SEARCH),
              child: Container(
                width: Get.width,
                padding: EdgeInsets.all(Dimensions.height10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search your desired food",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20.sp,
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
      body: Column(
        children: [
          SizedBox(height: Dimensions.height10),
          GetBuilder<HomeController>(builder: (homeController) {
            return homeController.productRating.isNotEmpty
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await _loadResources();
                      },
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HomeCategories(),
                            SizedBox(height: Dimensions.height20),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.width30,
                                bottom: Dimensions.height15,
                              ),
                              child: BigText(
                                text: 'Highest Rated',
                              ),
                            ),
                            // slider section
                            GetBuilder<HomeController>(builder: (homeC) {
                              return SizedBox(
                                height: Dimensions.pageView,
                                child: PageView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  controller: pageController,
                                  itemCount: 7,
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
                                    dotsCount:
                                        homeController.productRating.isEmpty
                                            ? 1
                                            : 7,
                                    position: _currPageValue.toInt(),
                                    decorator: DotsDecorator(
                                      activeColor: Colors.blue,
                                      size: const Size.square(9.0),
                                      activeSize: const Size(18.0, 9.0),
                                      activeShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                  );
                                }),
                              ],
                            ),

                            //Popular text
                            SizedBox(height: Dimensions.height20),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: Dimensions.width30),
                              child: BigText(
                                text: 'Newest Products',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width30),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1.6,
                                  crossAxisSpacing: 10,
                                ),
                                itemCount: homeController.productNewest.length,
                                itemBuilder: (context, index) {
                                  var product =
                                      homeController.productNewest[index];
                                  double totalRating = 0;
                                  double avgRating = 0;
                                  for (int i = 0;
                                      i < product.rating!.length;
                                      i++) {
                                    totalRating += product.rating![i].rating;
                                  }
                                  if (totalRating != 0) {
                                    avgRating =
                                        totalRating / product.rating!.length;
                                  }

                                  double docs =
                                      product.price / product.oldPrice * 100;
                                  return product.quantity == 0
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () => Get.toNamed(
                                            Routes.PRODUCT_DETAILS_NEWEST,
                                            arguments: {
                                              'product': product,
                                              'ratings': product.rating,
                                            },
                                          ),
                                          child: Column(
                                            children: [
                                              //image section
                                              Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 130.sp,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                          Dimensions.radius20,
                                                        ),
                                                        topRight:
                                                            Radius.circular(
                                                          Dimensions.radius20,
                                                        ),
                                                      ),
                                                      color: Colors.white38,
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
                                                              color: AppColors
                                                                  .originColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                  10.sp,
                                                                ),
                                                                topLeft: Radius
                                                                    .circular(
                                                                  Dimensions
                                                                      .radius20,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Disc %${docs.round()}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18.sp,
                                                                    //decoration: TextDecoration.lineThrough,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                  avgRating != 0.0
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                              Dimensions
                                                                  .width10,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .starColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                Dimensions
                                                                    .radius15,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 1,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 20,
                                                                ),
                                                                Text(
                                                                  avgRating
                                                                      .toString(),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(3.sp),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                      Dimensions.radius20,
                                                    ),
                                                    bottomRight:
                                                        Radius.circular(
                                                      Dimensions.radius20,
                                                    ),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 100.sp,
                                                          child: BigText(
                                                            text: product.name,
                                                            size: Dimensions
                                                                .font16,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5.sp),
                                                    Row(
                                                      children: [
                                                        BigText(
                                                          text:
                                                              '\$${product.price.toString()}',
                                                          // color: AppColors.yellowColor,
                                                          size:
                                                              Dimensions.font20,
                                                        ),
                                                        const Spacer(),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                            5.sp,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .mainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              Dimensions
                                                                  .radius15,
                                                            ),
                                                            // boxShadow: [
                                                            //   BoxShadow(
                                                            //     blurRadius: 1,
                                                            //     offset: const Offset(0, 2),
                                                            //     color: Colors.grey.withOpacity(0.2),
                                                            //   ),
                                                            // ],
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                Icons.category,
                                                                color: Colors
                                                                    .black,
                                                                size: 15.sp,
                                                              ),
                                                              Text(
                                                                product
                                                                    .category,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .height10),
                                                  ],
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
                    ),
                  )
                : const Expanded(child: CustomLoader());
          }),
        ],
      ),
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
      onTap: () => Get.toNamed(
        Routes.PRODUCT_DETAILS_RATING,
        arguments: {
          'product': product,
          'ratings': product.rating,
        },
      ),
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                            right: Dimensions.width20,
                            bottom: 8.sp,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                              Dimensions.width10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.starColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
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
                                Icon(
                                  Icons.star,
                                  color: Colors.black,
                                  size: 20.sp,
                                ),
                                Text(
                                  avgRating.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5, 0),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(5, 0),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        right: Dimensions.width15,
                        left: Dimensions.width15,
                      ),
                      child: AppColumn(
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
