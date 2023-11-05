import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/core/widgets/custom_button.dart';
import 'package:shop_app/src/core/widgets/custom_loader.dart';
import 'package:shop_app/src/models/product_model.dart';
import 'package:shop_app/src/modules/favorite/controllers/favorite_controller.dart';
import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/themes/app_decorations.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/widgets/app_text.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {

  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  List<ProductModel> carts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.customAppBar(
        context,
        "Favorites",
      ),
      body: GetBuilder<FavoriteController>(builder: (favoriteController) {
        return favoriteController.isLoading == true
            ? CustomLoader()
            : Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ListView.builder(
                              itemCount:
                                  favoriteController.productFavorites.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 8.sp),
                              itemBuilder: (context, index) {
                                ProductModel product =
                                    favoriteController.productFavorites[index];
                                double totalRating = 0;
                                double avgRating = 0;

                                for (int i = 0;
                                    i < product.ratings!.length;
                                    i++) {
                                  totalRating += product.ratings![i].rating;
                                }
                                if (totalRating != 0) {
                                  avgRating =
                                      totalRating / product.ratings!.length;
                                }

                                selectedFlag[index] =
                                    selectedFlag[index] ?? false;
                                bool? isSelected = selectedFlag[index];

                                favoriteController.initProduct(product);

                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onLongPress: () => onLongPress(
                                          isSelected!, index, product),
                                      onTap: () =>
                                          onTap(isSelected!, index, product),
                                      child: Container(
                                        margin: EdgeInsets.all(8.sp),
                                        decoration: AppDecoration.productFavoriteCart(context, 5.sp).decoration,
                                        child: Slidable(
                                          key: Key('$product'),
                                          closeOnScroll: true,
                                          actionPane:
                                              SlidableStrechActionPane(),
                                          actionExtentRatio: 0.25,
                                          actions: <Widget>[
                                            IconSlideAction(
                                              caption: 'Archive',
                                              color: Colors.blue,
                                              icon: Icons.archive,
                                              onTap: () {},
                                            ),
                                          ],
                                          secondaryActions: <Widget>[
                                            IconSlideAction(
                                              caption: 'Delete',
                                              color: Colors.red,
                                              icon: Icons.delete,
                                              onTap: () => favoriteController
                                                  .changeMealFavorite(
                                                      product.id!),
                                            ),
                                          ],
                                          child: Row(
                                            children: [
                                              // image
                                              Container(
                                                width: 80.sp,
                                                height: 80.sp,
                                                decoration: BoxDecoration(
                                                  color: colorPrimary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.sp),
                                                    bottomLeft:
                                                        Radius.circular(5.sp),
                                                  ),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      product.images[0],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.sp),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(
                                                      product.name,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                    SizedBox(height: 5.sp),
                                                    AppText(
                                                      product.category,
                                                      type: TextType.medium,
                                                    ),
                                                    SizedBox(height: 5.sp),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '\$${product.price.toString()}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .copyWith(
                                                                    color:
                                                                        colorPrimary,
                                                                  ),
                                                        ),
                                                        SizedBox(width: 10.sp),
                                                        avgRating != 0.0
                                                            ? Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                  3.sp,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      colorPrimary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    5.sp,
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      color:
                                                                          mCL,
                                                                      size:
                                                                          13.sp,
                                                                    ),
                                                                    Text(
                                                                      avgRating
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            mCL,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              isSelectionMode
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        right: 10.sp,
                                                      ),
                                                      child: Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                favoriteController
                                                                    .setQuantity(
                                                                  true,
                                                                  product,
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                size: 15.sp,
                                                                color: fCL,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 5.sp),
                                                            Container(
                                                              height: 20.sp,
                                                              width: 20.sp,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      colorPrimary,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3.sp),
                                                              ),
                                                              child: AppText(
                                                                favoriteController
                                                                    .cartProducts[product.id].toString(),
                                                                type: TextType
                                                                    .medium,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 5.sp),
                                                            InkWell(
                                                              onTap: () {
                                                                favoriteController
                                                                    .setQuantity(
                                                                  false,
                                                                  product,
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                size: 15.sp,
                                                                color: fCL,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: _buildSelectIcon(
                                        isSelected!,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 20.sp,
                          right: 0.0,
                          left: 0.0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSelectionMode ? 60.sp : 40.sp,
                            ),
                            child: CustomButton(
                              buttomText: "Save To Cart",
                              onPressed: isSelectionMode
                                  ? () {
                                      favoriteController.addItems(carts);
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      }),
      floatingActionButton: _buildSelectAllButton(),
    );
  }

  void onTap(bool isSelected, int index, ProductModel product) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        isSelectionMode = selectedFlag.containsValue(true);
        carts.add(product);
      });
    } else {
      AppNavigator.push(
        AppRoutes.DETAILS_PRODUCT_RATING,
        arguments: {
          'product': product,
          'ratings': product.ratings,
        },
      );
    }
  }

  void onLongPress(bool isSelected, int index, ProductModel product) {
    setState(() {
      selectedFlag[index] = !isSelected;
      isSelectionMode = selectedFlag.containsValue(true);
      carts
        ..clear()
        ..add(product);
    });
  }

  Widget _buildSelectIcon(bool isSelected) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.indeterminate_check_box_rounded,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return Container();
    }
  }

  Widget? _buildSelectAllButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (isSelectionMode) {
      return FloatingActionButton(
        backgroundColor: colorPrimary,
        onPressed: _selectAll,
        child: Icon(
          isFalseAvailable ? Icons.done_all : Icons.remove_done,
        ),
      );
    } else {
      return null;
    }
  }

  void _selectAll() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    selectedFlag.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  //   Widget _actionPane(int index) {
  //   switch (index % 4) {
  //     case 0:
  //       return SlidableScrollActionPane();
  //     case 1:
  //       return SlidableDrawerActionPane();
  //     case 2:
  //       return SlidableStrechActionPane();
  //     case 3:
  //       return SlidableBehindActionPane();

  //     default:
  //       return SlidableScrollActionPane();
  //   }
  // }
}
