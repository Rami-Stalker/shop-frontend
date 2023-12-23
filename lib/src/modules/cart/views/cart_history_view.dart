import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/public/components.dart';
import '../../../routes/app_pages.dart';
import '../controllers/cart_controller.dart';
import '../../../themes/app_colors.dart';

import '../../../core/widgets/no_data_page.dart';
import '../../../models/cart_model.dart';
import '../../../public/constants.dart';
import '../../../utils/sizer_custom/sizer.dart';

class CartHistoryView extends GetView<CartController> {
  const CartHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CartModel> cartHistoryList =
        AppGet.CartGet.getCartHistoryList().reversed.toList();

    Map<String, int> cartItems = {};

    for (var i = 0; i < cartHistoryList.length; i++) {
      if (cartItems.containsKey(cartHistoryList[i].time)) {
        cartItems.update(cartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItems.putIfAbsent(cartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsVal() {
      return cartItems.entries.map((e) => e.value).toList();
    }

    List<String> cartItemsKey() {
      return cartItems.entries.map((e) => e.key).toList();
    }

    List<int> itemsVal = cartItemsVal();

    int listCounter = 0;

    Widget _timeWidget(int index) {
      String outputDate = DateTime.now().toString();
      if (index < cartHistoryList.length) {
        DateTime parseDate = DateFormat("yyy-MM-dd HH:mm:ss")
            .parse(cartHistoryList[listCounter].time!);
        DateTime inputDate = DateTime.parse(parseDate.toString());
        DateFormat outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return AppText(outputDate);
    }

    int price = 0;

    void _itemPrice(int index) {
      if (index < cartHistoryList.length) {
        price += cartHistoryList[listCounter].price! *
            cartHistoryList[listCounter].userQuant!;
      }
    }

    return SafeArea(
      child: ListView(
        children: [
          Components.customHeadIconViews(
            'cart_history'.tr,
            Icons.shopping_cart_outlined,
            () => AppNavigator.push(AppRoutes.CART),
          ),
          controller.getCartHistoryList().isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                    vertical: 20.sp,
                  ),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      for (int i = 0; i < itemsVal.length; i++)
                        Container(
                          height: 100.sp,
                          margin: EdgeInsets.only(bottom: 20.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _timeWidget(listCounter),
                              SizedBox(height: 10.sp),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children:
                                        List.generate(itemsVal[i], (index) {
                                      if (listCounter <
                                          cartHistoryList.length) {
                                        listCounter++;
                                      }
                                      _itemPrice(listCounter);
                                      return index <= 2
                                          ? Container(
                                              height: 70.sp,
                                              width: 70.sp,
                                              margin: EdgeInsets.only(
                                                right: 5.sp,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  7.sp,
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    cartHistoryList[
                                                            listCounter - 1]
                                                        .image!,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }),
                                  ),
                                  SizedBox(
                                    // height: 70.sp,
                                    width: 100.sp,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText('total'.tr,
                                                type: TextType.medium),
                                            SizedBox(width: 10.sp),
                                            AppText('\$${price.toString()}'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              'items'.tr,
                                              type: TextType.medium,
                                            ),
                                            SizedBox(width: 10.sp),
                                            AppText(itemsVal[i].toString()),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            List<String> orderTime =
                                                cartItemsKey();
                                            Map<String, CartModel> moreOrder =
                                                {};
                                            for (int j = 0;
                                                j < cartHistoryList.length;
                                                j++) {
                                              if (cartHistoryList[j].time ==
                                                  orderTime[i]) {
                                                moreOrder.putIfAbsent(
                                                  cartHistoryList[j].id!,
                                                  () => CartModel.fromJson(
                                                      jsonDecode(jsonEncode(
                                                    cartHistoryList[j],
                                                  ))),
                                                );
                                              }
                                            }
                                            AppGet.CartGet.setItems = moreOrder;
                                            AppGet.CartGet.addToCartList();
                                            AppNavigator.push(AppRoutes.CART);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.sp,
                                              vertical: 5.sp,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5.sp,
                                              ),
                                              border: Border.all(
                                                width: 1,
                                                color: colorPrimary,
                                              ),
                                            ),
                                            child: Text(
                                              'one_more'.tr,
                                              style: TextStyle(
                                                color: colorPrimary,
                                                fontSize: 9.sp,
                                              ),
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
                )
              : SizedBox(
                  height: 400.sp,
                  child: Center(
                    child: NoDataPage(
                      text: 'cart_history_empty'.tr,
                      imgPath: AppConstants.EMPTY_ASSET,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
