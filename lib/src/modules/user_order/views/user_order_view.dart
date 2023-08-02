import 'package:shop_app/src/core/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/modules/user_order/controllers/user_order_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../models/order_model.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';

import '../../../themes/app_colors.dart';
import '../widgets/build_shimmer_order.dart';

class UserOrderView extends GetView<UserOrderController> {
  const UserOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: colorPrimary,
          width: double.maxFinite,
          height: 100.sp,
          padding: EdgeInsets.only(top: Dimensions.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: 'Your Order',
                color: Colors.white,
              ),
            ],
          ),
        ),
        FutureBuilder<List<OrderModel>>(
            future: controller.fetchUserOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              OrderModel userOrder = snapshot.data![index];
                              return Container(
                                height: 130.sp,
                                margin: EdgeInsets.only(
                                  bottom: Dimensions.height20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: DateFormat("MM/dd/yyyy hh:mm a")
                                          .format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            userOrder.orderedAt),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                            userOrder.products.length,
                                            (indes) => indes < 3
                                                ? Container(
                                                    height: 100.sp,
                                                    width: 100.sp,
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
                                                          userOrder
                                                              .products[indes]
                                                              .images[0],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 100.sp,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'total:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                  // BigText(
                                                  //   text: 'total:',
                                                  //   size: 16,
                                                  //   color: AppColors.titleColor,
                                                  // ),
                                                  SizedBox(
                                                    width: Dimensions.width10,
                                                  ),
                                                  Text(
                                                    '\$${userOrder.totalPrice.toString()}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.toNamed(
                                                  Routes.ORDER_DETAILS,
                                                  arguments: userOrder,
                                                ),
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
                                                    text: 'Details',
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return const Expanded(
                  child: NoDataPage(
                    text: "Your cart history is empty",
                    imgPath: Constants.EMPTY_ASSET,
                  ),
                );
              }
              return Expanded(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return BuildShimmerOrder();
                    },
                  ),
                ),
              );
            }),
      ],
    );
  }
}
