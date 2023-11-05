import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/dialogs/dialog_confirm.dart';
import 'package:shop_app/src/core/dialogs/dialog_loading.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';

import '../../../routes/app_pages.dart';
import '../controllers/cart_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';

import '../../../public/components.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../public/constants.dart';
import '../../../themes/app_decorations.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartView> {
  final bool _isLogged = AppGet.authGet.onAuthCheck();
  CartController cartController = AppGet.CartGet;

  @override
  Widget build(BuildContext context) {
    cartController.getCartList();
    return Scaffold(
      appBar: Components.customAppBar(
        context,
        "Cart",
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cartController.getItems.isNotEmpty
                ? MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Expanded(
                      child: Stack(
                        children: [
                          ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cartController.getItems.length,
                                itemBuilder: (_, index) {
                                  var product = cartController.getItems[index];
                                  cartController.quantity.value =
                                      product.userQuant!;
                                  return GestureDetector(
                                    onTap: () {
                                      AppNavigator.push(
                                        AppRoutes.DETAILS_PRODUCT_RATING,
                                        arguments: {
                                          'product': product.product,
                                          'ratings': product.rating,
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8.sp),
                                      decoration:
                                          AppDecoration.productFavoriteCart(
                                                  context, 5.sp)
                                              .decoration,
                                      child: Row(
                                        children: [
                                          // image
                                          Container(
                                            width: 80.sp,
                                            height: 80.sp,
                                            decoration: BoxDecoration(
                                              color: colorPrimary,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.sp),
                                                bottomLeft:
                                                    Radius.circular(5.sp),
                                              ),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  product.image!,
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
                                                  product.name!,
                                                  overflow: TextOverflow.clip,
                                                ),
                                                SizedBox(height: 5.sp),
                                                Container(
                                                  height: 14.sp,
                                                  child: Row(
                                                    children: [
                                                      AppText(
                                                        cartController
                                                                    .quantity ==
                                                                1
                                                            ? "${cartController.quantity.toString()} Dish"
                                                            : "${cartController.quantity.toString()} Dishs",
                                                        type: TextType.small,
                                                      ),
                                                      VerticalDivider(),
                                                      AppText(
                                                        "Normal",
                                                        type: TextType.small,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.sp),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '\$${product.price.toString()}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            color: colorPrimary,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10.sp),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              cartController
                                                                  .setQuantity(
                                                                false,
                                                                product.product!
                                                                    .quantity,
                                                              );
                                                              if (cartController
                                                                  .isValid
                                                                  .value) {
                                                                cartController
                                                                    .addItem(
                                                                  product
                                                                      .product!,
                                                                  product.userQuant! -
                                                                      1,
                                                                );
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 7.sp,
                                                              backgroundColor:
                                                                  colorPrimary,
                                                              child: Icon(
                                                                Icons.remove,
                                                                size: 12.sp,
                                                                color: mCL,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5.sp),
                                                          AppText(
                                                            cartController
                                                                .quantity
                                                                .toString(),
                                                            type:
                                                                TextType.medium,
                                                          ),
                                                          SizedBox(width: 5.sp),
                                                          InkWell(
                                                            onTap: () {
                                                              cartController
                                                                  .setQuantity(
                                                                true,
                                                                product.product!
                                                                    .quantity,
                                                              );
                                                              if (cartController
                                                                  .isValid
                                                                  .value) {
                                                                cartController
                                                                    .addItem(
                                                                  product
                                                                      .product!,
                                                                  product.userQuant! +
                                                                      1,
                                                                );
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 7.sp,
                                                              backgroundColor:
                                                                  colorPrimary,
                                                              child: Icon(
                                                                Icons.add,
                                                                size: 12.sp,
                                                                color: mCL,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                horizontal: 40.sp,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: SizerUtil.width,
                                  height: 35.sp,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_isLogged) {
                                        if (AppGet.authGet.userModel!.address ==
                                                "" &&
                                            AppGet.authGet.userModel!.phone
                                                .isEmpty) {
                                          AppNavigator.push(
                                            AppRoutes.EDIT_INFO_USER,
                                          );
                                        } else {
                                          AppNavigator.push(AppRoutes.CHECKOUT);
                                        }
                                      } else {
                                        dialogAnimationWrapper(
                                          context: context,
                                          slideFrom: 'bottom',
                                          child: DialogConfirm(
                                            title: 'Sign in',
                                            subTitle:
                                                'You should Sign in to complete \n do you want Sign in ?',
                                            handleConfirm: () {
                                              AppNavigator.replaceWith(
                                                  AppRoutes.LOGIN);
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: colorPrimary,
                                      minimumSize: Size(
                                        SizerUtil.width,
                                        35.sp,
                                      ),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.sp),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Place Order",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        SizedBox(width: 3.sp),
                                        Text(
                                          "-",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        SizedBox(width: 3.sp),
                                        Text(
                                          '(\$${cartController.subtotal.toString()})',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Expanded(
                    child: NoDataPage(
                      text: 'Your cart is empty',
                      imgPath: AppConstants.EMPTY_ASSET,
                    ),
                  ),
          ],
        ),
      ),
      // bottomNavigationBar: cartController.getItems.isNotEmpty
      //     ? Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Container(
      //             // height: 130.sp,
      //             padding: EdgeInsets.symmetric(
      //               horizontal: 20.sp,
      //               vertical: 20.sp,
      //             ),
      //             decoration:
      //                 AppDecoration.bottomNavigationBar(context).decoration,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.end,
      //               children: [
      //                 Container(
      //                   padding: EdgeInsets.all(15.sp),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.sp),
      //                     color: Get.isDarkMode ? mCM : mCL,
      //                   ),
      //                   child: Text(
      //                     '\$ ${cartController.totalAmount.toString()}',
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .titleLarge!
      //                         .copyWith(color: colorBlack),
      //                   ),
      //                 ),
      //                 SizedBox(height: 15.sp),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     AppTextButton(
      //                       txt: 'Save Cart',
      //                       onTap: () {
      //                         cartController.addToCartHistoryList();
      //                       },
      //                     ),
      //                     SizedBox(width: 10.sp),
      //                     AppText('OR'),
      //                     SizedBox(width: 10.sp),
      //                     AppTextButton(
      //                       txt: 'Check Out',
      //                       onTap: () {
      //                         if (_isLogged) {
      //                           if (AppGet.authGet.userModel!.address == "" &&
      //                               AppGet.authGet.userModel!.phone.isEmpty) {
      //                             AppNavigator.push(AppRoutes.EDIT_INFO_USER);
      //                           } else {
      //                             AppNavigator.push(AppRoutes.CHECKOUT);
      //                           }
      //                         } else {
      //                           dialogAnimationWrapper(
      //                             context: context,
      //                             slideFrom: 'bottom',
      //                             child: DialogConfirm(
      //                             title: 'Sign in',
      //                             subTitle: 'You should Sign in to complete \n do you want Sign in ?',
      //                             handleConfirm: (){
      //                               AppNavigator.replaceWith(AppRoutes.LOGIN);
      //                             },
      //                           ),
      //                           );
      //                         }
      //                       },
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       )
      //     : null,
    );
  }
}
