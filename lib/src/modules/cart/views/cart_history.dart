import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/src/themes/app_colors.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../core/widgets/small_text.dart';
import '../../../models/cart_model.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/sizer_custom/sizer.dart';

class CartHistoryView extends GetView<CartController> {
  const CartHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartCtrl = Get.find<CartController>();

    List<CartModel> cartHistoryList =
        cartCtrl.getCartHistoryList().reversed.toList();

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

    Widget timeWidget(int index) {
      String outputDate = DateTime.now().toString();
      if (index < cartHistoryList.length) {
        DateTime parseDate = DateFormat("yyy-MM-dd HH:mm:ss")
            .parse(cartHistoryList[listCounter].time!);
        DateTime inputDate = DateTime.parse(parseDate.toString());
        DateFormat outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          //header
          Container(
            color: colorPrimary,
            width: double.maxFinite,
            height: 80.sp,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              right: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40.sp,
                ),
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                AppIcon(
                  onTap: () => Get.toNamed(Routes.CART),
                  icon: Icons.shopping_cart_outlined,
                  backgroundColor: colorMedium,
                ),
              ],
            ),
          ),
          //body
          // GetBuilder<CartCtrl>(
          //   builder: (controller) =>
          controller.getCartHistoryList().isNotEmpty
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          for (int i = 0; i < itemsVal.length; i++)
                            Container(
                              height: 100.sp,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
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
                                        height: 70.sp,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Total',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              '${itemsVal[i]} Items',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                List<String> orderTime =
                                                    cartItemsKey();
                                                Map<String, CartModel>
                                                    moreOrder = {};
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
                                                cartCtrl.setItems = moreOrder;
                                                cartCtrl.addToCartList();
                                                Get.toNamed(Routes.CART);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width10,
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
                                                child: SmallText(
                                                  text: 'one more',
                                                  color: colorPrimary,
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
                  ),
                )
              : const Expanded(
                  child: NoDataPage(
                    text: 'Your cart history is empty',
                    imgPath: Constants.EMPTY_ASSET,
                  ),
                ),
        ],
      ),
    );
  }
}
