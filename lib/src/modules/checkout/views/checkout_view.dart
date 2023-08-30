import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/models/user_model.dart';

import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../models/cart_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/payment/paypal_service.dart';
import '../../../themes/app_decorations.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Check out",
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width10,
          vertical: Dimensions.height20,
          ),
        child: Container(
          height: Dimensions.screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.height20,
              ),
              Text(
                'Shipping Address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: Dimensions.height20),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.UPDATE_PROFILE),
                child: Container(
                  padding: EdgeInsets.all(
                    Dimensions.width10,
                  ),
                  decoration: AppDecoration.dots(context, 10.sp).decoration,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.sp,
                        backgroundColor: colorPrimary.withOpacity(0.4),
                        child: AppIcon(
                          backgroundColor: colorPrimary,
                          iconColor: mCL,
                          onTap: () {},
                          icon: Icons.location_on,
                          iconSize: 20.sp,
                        ),
                      ),
                      SizedBox(width: Dimensions.width20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Home',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 13.sp),
                          ),
                          SizedBox(height: 5.sp),
                          SizedBox(
                            width: 150.sp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.phone,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 10.sp),
                                ),
                                Text(
                                  user.address,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 10.sp),
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
              SizedBox(height: Dimensions.height45),
              Text(
                'Payment Methods',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: Dimensions.height20),
              RadioWidget(
                image: Constants.PAYPAL_ASSET,
                title: 'Paypal',
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
              Spacer(),
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
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '\$ ${cartController.totalAmount + 100}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: colorPrimary),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: 80.sp,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
              vertical: Dimensions.height20,
            ),
            decoration: AppDecoration.bottomNavigationBar(context).decoration,
            child: GetBuilder<CheckoutController>(
              builder: (checkoutController) {
                return AppTextButton(
                  txt: 'Apply',
                  onTap: () {
                    if (user.address != "" ||
                                  user.phone.isNotEmpty) {
                                if (_order == Ordered.cashOnDelivery) {
                                  checkoutController.checkout(
                                    productsId: productsId,
                                    userQuants: userQuants,
                                    totalPrice: cartController.totalAmount,
                                    address: user.address,
                                  );
                                }  else if (_order == Ordered.paypal) {
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
                                        address: user.address,
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
              }
            ),
          ),
        ],
      ),
    );
  }
}
