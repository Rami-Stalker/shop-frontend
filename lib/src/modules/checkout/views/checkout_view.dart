import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/dialogs/dialog_loading.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/stripe_payment/payment_manager.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../models/cart_model.dart';
import '../../../utils/sizer_custom/sizer.dart';
import '../widgets/items_widget.dart';
import '../widgets/radio_widget.dart';

enum Ordered {
  paypal,
  cashOnDelivery,
}

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  Ordered? _order = Ordered.paypal;

  @override
  Widget build(BuildContext context) {
    UserModel user = AppGet.authGet.userModel!;
    CartController cartController = AppGet.CartGet;
    List<CartModel> getItems = cartController.getItems;

    List<int> userQuants = [];
    List<String> productsId = [];

    for (var i = 0; i < getItems.length; i++) {
      userQuants.add(getItems[i].userQuant!);
      productsId.add(getItems[i].id!);
    }

    return Scaffold(
      appBar: Components.customAppBar(
        context,
        "Check out",
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
        horizontal: 10.sp,
      ),
        children: [
          SizedBox(height: 10.sp),
          AppText('Shipping Address'),
          SizedBox(height: 10.sp),
          GestureDetector(
            onTap: () => AppNavigator.push(AppRoutes.EDIT_INFO_USER),
            child: Components.customContainer(
              context,
              Row(
                children: [
                  CircleAvatar(
                    radius: 19.sp,
                    backgroundColor: colorPrimary.withOpacity(0.4),
                    child: AppIcon(
                      backgroundColor: colorPrimary,
                      iconColor: mCL,
                      onTap: () {},
                      icon: Icons.location_on,
                      iconSize: 20.sp,
                    ),
                  ),
                  SizedBox(width: 20.sp),
                  GetBuilder<AuthController>(
                    builder: (authController) {
                      UserModel userInfo = authController.userModel!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.sp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  userInfo.phone,
                                  type: TextType.small,
                                ),
                                SizedBox(height: 5.sp),
                                AppText(
                                  userInfo.address,
                                  maxLines: 1,
                                  type: TextType.small,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  const Spacer(),
                  const Icon(Icons.edit_note_outlined),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.sp),
          AppText('Payment Methods'),
          SizedBox(height: 10.sp),
          RadioWidget(
            image: AppConstants.PAYPAL_ASSET,
            title: 'Check Payments',
            radio: Radio<Ordered>(
              activeColor: colorPrimary,
              value: Ordered.paypal,
              groupValue: _order,
              onChanged: (Ordered? val) {
                setState(() {
                  _order = val;
                });
              },
            ),
          ),
          RadioWidget(
            image: AppConstants.CASH_ASSET,
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
          SizedBox(height: 20.sp),
          AppText('Order Summary'),
          SizedBox(height: 10.sp),
          Components.customContainer(
            context,
            Column(
              children: [
                ItemsWidget(
                  txt: '${getItems.length.toString()} Items',
                  account:
                      '\$${cartController.subtotal.toStringAsFixed(2)}',
                ),
                ItemsWidget(
                  txt: 'Shipping',
                  account: '\$0.00',
                ),
                ItemsWidget(
                  txt: 'Tax (14%)',
                  account: '\$${cartController.tax.toStringAsFixed(2)}',
                ),
                ItemsWidget(
                  txt: 'Discount',
                  account:
                      '\$${cartController.discount.toStringAsFixed(2)}',
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 17.sp),
                      ),
                      Text(
                        '\$${cartController.total.toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 17.sp, color: colorPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40.sp,
              vertical: 25.sp,
            ),
            child: GetBuilder<CheckoutController>(
                builder: (checkoutController) {
              return CustomButton(
                buttomText: "Aplly",
                onPressed: () {
                  if (user.address != "" || user.phone.isNotEmpty) {
                    if (_order == Ordered.cashOnDelivery) {
                      checkoutController.checkout(
                        productsId: productsId,
                        userQuants: userQuants,
                        totalPrice: cartController.subtotal,
                        address: user.address,
                      );
                    } else if (_order == Ordered.paypal) {
                      PaymentManager.makePayment(
                        amount: cartController.subtotal,
                        currency: 'USD',
                      ).then((value) {
                        showDialogLoading(context);
                        checkoutController.checkout(
                          productsId: productsId,
                          userQuants: userQuants,
                          totalPrice: cartController.subtotal,
                          address: user.address,
                        );
                      });
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
    );
  }
}
