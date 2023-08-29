import 'package:shop_app/src/controller/app_controller.dart';

import '../../../core/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/order_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../core/widgets/no_data_page.dart';
import '../../../models/order_model.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';

import '../../../themes/app_colors.dart';
import '../widgets/build_shimmer_order.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          'Orders',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: AppGet.authGet.userModel?.type == "user" ? controller.fetchUserOrders() : controller.fetchAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
                // vertical: Dimensions.height10,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  OrderModel userOrder = snapshot.data![index];
                  return Container(
                    height: 100.sp,
                    margin: EdgeInsets.only(
                      bottom: Dimensions.height20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("MM/dd/yyyy hh:mm a").format(
                            DateTime.fromMillisecondsSinceEpoch(
                              userOrder.orderedAt,
                            ),
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: Dimensions.height10),
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
                                          borderRadius: BorderRadius.circular(
                                            7.sp,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              userOrder
                                                  .products[indes].images[0],
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'total:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
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
                                        horizontal: Dimensions.width10,
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
            );
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return NoDataPage(
              text: "Order is empty",
              imgPath: Constants.EMPTY_ASSET,
            );
          }
          return BuildShimmerOrder();
        },
      ),
    );
  }
}
