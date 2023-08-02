import 'package:shop_app/src/controller/user_controller.dart';
import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/core/widgets/custom_button.dart';
import 'package:shop_app/src/core/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/src/modules/checkout/controllers/checkout_controller.dart';
import 'package:shop_app/src/public/constants.dart';
import 'package:shop_app/src/themes/app_colors.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../models/cart_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/payment/paypal_service.dart';
import '../../../themes/app_decorations.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../widgets/items_widget.dart';
import '../widgets/radio_widget.dart';

enum Ordered {
  visa,
  googlePay,
  applePay,
  cashOnDelivery,
}

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  Ordered? _order = Ordered.visa;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    CartController cartController = Get.find<CartController>();
    List<CartModel> getItems = cartController.getItems;

    List<int> userQuants = [];
    List<String> productsId = [];

    for (var i = 0; i < getItems.length; i++) {
      userQuants.add(getItems[i].userQuant!);
      productsId.add(getItems[i].id!);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: AppDecoration.appbarIcon(context, 5.sp).decoration,
              child: Icon(Icons.arrow_back_ios, size: 10.sp),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Text(
                        'Shipping Address',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(height: Dimensions.height10),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.UPDATE_PROFILE),
                        child: Container(
                          padding: EdgeInsets.only(
                            right: Dimensions.width10,
                            left: Dimensions.width20,
                            top: Dimensions.width10,
                            bottom: Dimensions.width10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.sp,
                                backgroundColor: colorPrimary.withOpacity(0.4),
                                child: AppIcon(
                                  backgroundColor: colorPrimary,
                                  iconColor: Colors.white,
                                  onTap: () {},
                                  icon: Icons.location_on,
                                  iconSize: 25.sp,
                                ),
                              ),
                              SizedBox(width: Dimensions.width30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5.sp),
                                  SizedBox(
                                    width: 400.sp,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SmallText(
                                          overflow: TextOverflow.ellipsis,
                                          text: userController.user.phone,
                                        ),
                                        SmallText(
                                          overflow: TextOverflow.ellipsis,
                                          text: userController.user.address,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(Icons.edit_note_outlined),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height30),
                      Text(
                        'Payment Methods',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(height: Dimensions.height10),
                      RadioWidget(
                        image: Constants.PAYPAL_ASSET,
                        title: 'Paypal',
                        radio: Radio<Ordered>(
                          activeColor: colorPrimary,
                          value: Ordered.visa,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      RadioWidget(
                        image: Constants.CASH_ASSET,
                        title: 'Cash on delivery',
                        radio: Radio<Ordered>(
                          activeColor: colorPrimary,
                          value: Ordered.cashOnDelivery,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.height30),
                      ItemsWidget(
                        txt: '${getItems.length.toString()} Items',
                        account: '\$ ${cartController.totalAmount.toString()}',
                      ),
                      const ItemsWidget(
                        txt: 'ShippingFee',
                        account: '\$ 100',
                      ),
                      cartController.totalOldAmount != 0
                          ? ItemsWidget(
                              txt: 'Discount',
                              account:
                                  '\$ ${cartController.totalOldAmount - cartController.totalAmount}',
                            )
                          : Container(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(text: "Total"),
                          BigText(
                            text: '\$ ${cartController.totalAmount + 100}',
                            color: colorPrimary,
                            size: 22,
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height30),
                      Container(
                        padding: EdgeInsets.only(
                          right: Dimensions.width20,
                          left: Dimensions.width20,
                          top: Dimensions.width30,
                          bottom: Dimensions.width30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: GetBuilder<CheckoutController>(
                            builder: (checkoutController) {
                          return CustomButton(
                            buttomText: 'Apply',
                            onPressed: () {
                              if (userController.user.address != "" ||
                                  userController.user.phone.isNotEmpty) {
                                if (_order == Ordered.cashOnDelivery) {
                                  checkoutController.checkout(
                                    productsId: productsId,
                                    userQuants: userQuants,
                                    totalPrice: cartController.totalAmount,
                                    address: userController.user.address,
                                  );
                                } else {
                                  PaypalService(
                                    total: cartController.totalAmount,
                                    items: [
                                      {
                                        "": "",
                                      }
                                    ],
                                    onSuccess: (Map params) async {
                                      checkoutController.checkout(
                                        productsId: productsId,
                                        userQuants: userQuants,
                                        totalPrice: cartController.totalAmount,
                                        address: userController.user.address,
                                      );
                                    },
                                  );
                                }
                              } else {
                                Components.showSnackBar(
                                  'Your Data is not completed',
                                );
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
