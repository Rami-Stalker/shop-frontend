import 'package:shop_app/src/controller/user_controller.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/src/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/components/app_components.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartView> {
  final bool _isLogged = Get.find<AuthController>().userLoggedIn();
  CartController cartController = Get.find<CartController>();
  UserController userController = Get.find<UserController>();
  //double heightNav = Dimensions.bottomHeightBar + 130;

  @override
  Widget build(BuildContext context) {
    cartController.getCartList();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: Dimensions.height15),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
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
                              borderRadius: BorderRadius.circular(
                                5.sp,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 14.sp,
                            ),
                          ),
                        ),
                        Text(
                          "Cart",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        Container(
                          width: 40.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Divider(),
                  ],
                ),
              ),
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
                                        'product':
                                            product.product,
                                        'ratings':
                                            product.rating,
                                      },
                                    );
                                  },
                                  child: Card(
                                    child: Row(
                                      children: [
                                        //image
                                        Container(
                                          width: 100.sp,
                                          height: 100.sp,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                10.sp,
                                              ),
                                              bottomLeft: Radius.circular(
                                                10.sp,
                                              ),
                                            ),
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
                                              BigText(
                                                text: product.name!,
                                                color: Colors.black54,
                                                overflow: TextOverflow.clip,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        '\$ ${product.price.toString()}',
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: Dimensions.width10,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom:
                                                          Dimensions.height10,
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Dimensions.radius20,
                                                      ),
                                                      color: Colors.grey[100],
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
                                                                .isValid
                                                                .value) {
                                                              cartController
                                                                  .addItem(
                                                                product.id,
                                                                product
                                                                    .product!,
                                                                product.userQuant! -
                                                                    1,
                                                              );
                                                            }
                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: 5.sp),
                                                        BigText(
                                                          text: cartController
                                                              .quantity
                                                              .toString(),
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
                                                                product.id,
                                                                product
                                                                    .product!,
                                                                product.userQuant! +
                                                                    1,
                                                              );
                                                            }
                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
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
      ),
      bottomNavigationBar: cartController.getItems.isNotEmpty
          ? Container(
              height: Dimensions.bottomHeightBar + 130,
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                right: Dimensions.width20,
                left: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.sp),
                  topRight: Radius.circular(40.sp),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10.sp),
                      color: Colors.white,
                    ),
                    child: BigText(
                        text: '\$ ${cartController.totalAmount.toString()}'),
                  ),
                  SizedBox(height: Dimensions.height15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextButton(
                        txt: 'Save Cart',
                        onTap: () {
                          cartController.addToCartHistoryList();
                          Get.toNamed(Routes.USER_NAVIGATOR);
                        },
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      const Text('OR'),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      AppTextButton(
                        txt: 'Check Out',
                        onTap: () {
                          if (_isLogged) {
                            if (userController.user.address == "" &&
                                userController.user.phone.isEmpty) {
                              Get.toNamed(Routes.UPDATE_PROFILE);
                            } else {
                              Get.toNamed(Routes.CHECKOUT);
                            }
                          } else {
                            AppComponents.showCustomDialog(
                              context: context,
                              msg:
                                  'You should Sign in to complete \n do you want Sign in ?',
                              ok: () {
                                Get.offNamedUntil(
                                    Routes.SIGN_IN, (route) => false);
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
            )
          : null,
    );
  }
}
