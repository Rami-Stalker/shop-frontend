import 'package:shop_app/src/controller/app_controller.dart';

import '../controllers/cart_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../public/components.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_decorations.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartView> {
  final bool _isLogged = AppGet.authGet.onAuthCheck();
  CartController cartController = AppGet.CartGet;
  //double heightNav = Dimensions.bottomHeightBar + 130;

  @override
  Widget build(BuildContext context) {
    cartController.getCartList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: AppDecoration.appbarIcon(context, 5.sp).decoration,
              child: Icon(
                Icons.arrow_back_ios,
                size: 15.sp,
                color: Get.isDarkMode ? mCL : colorBlack,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          child: Divider(),
          preferredSize: Size(
            Dimensions.screenWidth,
            20,
          ),
        ),
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
                      child: ListView(
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
                                  Get.toNamed(
                                    Routes.PRODUCT_DETAILS_RATING,
                                    arguments: {
                                      'product': product.product,
                                      'ratings': product.rating,
                                    },
                                  );
                                },
                                child: Card(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80.sp,
                                        height: 80.sp,
                                        decoration: BoxDecoration(
                                          color: mCL,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              product.image!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              product.name!,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '\$ ${product.price.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                          color:
                                                              Colors.redAccent),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: Dimensions.width10,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.radius20,
                                                    ),
                                                    color: Get.isDarkMode
                                                        ? mCM
                                                        : mCL,
                                                  ),
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
                                                              .isValid.value) {
                                                            cartController
                                                                .addItem(
                                                              product.id,
                                                              product.product!,
                                                              product.userQuant! -
                                                                  1,
                                                            );
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: fCL,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5.sp),
                                                      Text(
                                                        cartController.quantity
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                                color:
                                                                    colorBlack),
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
                                                              .isValid.value) {
                                                            cartController
                                                                .addItem(
                                                              product.id,
                                                              product.product!,
                                                              product.userQuant! +
                                                                  1,
                                                            );
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: fCL,
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
                    ),
                  )
                : const Expanded(
                    child: NoDataPage(
                      text: 'Your cart is empty',
                      imgPath: Constants.EMPTY_ASSET,
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: cartController.getItems.isNotEmpty
          ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  // height: 130.sp,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20,
                  ),
                  decoration: AppDecoration.bottomNavigationBar(context).decoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Get.isDarkMode ? mCM : mCL,
                        ),
                        child: Text(
                          '\$ ${cartController.totalAmount.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: colorBlack),
                        ),
                      ),
                      SizedBox(height: Dimensions.height15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextButton(
                            txt: 'Save Cart',
                            onTap: () {
                              cartController.addToCartHistoryList();
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
                            txt: 'Check Out',
                            onTap: () {
                              if (_isLogged) {
                                if (AppGet.authGet.userModel!.address == "" &&
                                    AppGet.authGet.userModel!.phone.isEmpty) {
                                  Get.toNamed(Routes.UPDATE_PROFILE);
                                } else {
                                  Get.toNamed(Routes.CHECKOUT);
                                }
                              } else {
                                Components.showCustomDialog(
                                  context: context,
                                  msg:
                                      'You should Sign in to complete \n do you want Sign in ?',
                                  ok: () {
                                    Get.offNamedUntil(
                                        Routes.LOGIN, (route) => false);
                                  },
                                  okColor: Colors.blue,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          )
          : null,
    );
  }
}
