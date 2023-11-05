import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';
import '../controllers/order_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../core/widgets/no_data_page.dart';
import '../../../models/order_model.dart';
import '../../../public/constants.dart';

import '../../../themes/app_colors.dart';
import '../widgets/custom_shimmer_order.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: AppText('Orders'),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: AppGet.authGet.userModel?.type == "user"
            ? controller.fetchUserOrders()
            : controller.fetchAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.sp,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  OrderModel userOrder = snapshot.data![index];
                  return Column(
                    children: [
                      SizedBox(height: 5.sp),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 3.sp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              DateFormat("MM/dd/yyyy hh:mm a").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  userOrder.orderedAt,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(
                                    userOrder.products.length,
                                    (indes) => indes < 3
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
                                                  userOrder.products[indes]
                                                      .images[0],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ),
                                SizedBox(
                                  height: 70.sp,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          AppText('total:'),
                                          SizedBox(width: 5.sp),
                                          AppText(
                                            '\$${userOrder.totalPrice.toString()}',
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      GestureDetector(
                                        onTap: () => AppNavigator.push(
                                          AppRoutes.DETAILS_ORDER,
                                          arguments: {
                                            'order': userOrder,
                                          },
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.sp,
                                            vertical: 5.sp,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              5.sp,
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: colorPrimary,
                                            ),
                                          ),
                                          child: userOrder.status != 3
                                          ? AppText(
                                            'Details',
                                            type: TextType.small,
                                          ) : AppText(
                                            'Completed',
                                            type: TextType.small,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return NoDataPage(
              text: "Order is empty",
              imgPath: AppConstants.EMPTY_ASSET,
            );
          }
          return CustomShimmerOrder();
        },
      ),
    );
  }
}
