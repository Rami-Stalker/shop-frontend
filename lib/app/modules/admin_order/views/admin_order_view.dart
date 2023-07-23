import 'package:shop_app/app/core/utils/app_strings.dart';
import 'package:shop_app/app/core/widgets/no_data_page.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/app/modules/admin_order/controllers/admin_order_controller.dart';
import 'package:shop_app/app/routes/app_pages.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/order_model.dart';

class AdminOrderView extends GetView<AdminOrderController> {
  const AdminOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminOrderController>(
      builder: (adminOrderController) {
        return Column(
            children: [
              Container(
                color: AppColors.mainColor,
                width: double.maxFinite,
                height: Dimensions.height10 * 10,
                padding: EdgeInsets.only(top: Dimensions.height45),
                child: Center(
                  child: BigText(
                    text: "Custom's Order",
                    color: Colors.white,
                  ),
                ),
              ),
              adminOrderController.orders.isNotEmpty
                  ? adminOrderController.isLoading != true
                      ? MediaQuery.removePadding(
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
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemCount: adminOrderController.orders.length,
                                    itemBuilder: (context, index) {
                                      OrderModel order =
                                          adminOrderController.orders[index];
                                      return Container(
                                        height: Dimensions.height30 * 4,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BigText(
                                              text: DateFormat("MM/dd/yyyy hh:mm a")
                                                  .format(
                                                DateTime.fromMillisecondsSinceEpoch(
                                                    order.orderedAt),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Wrap(
                                                  direction: Axis.horizontal,
                                                  children: List.generate(
                                                    order.products.length,
                                                    (indes) => indes < 3
                                                        ? Container(
                                                            height: Dimensions
                                                                    .height20 *
                                                                4,
                                                            width: Dimensions
                                                                    .height20 *
                                                                4,
                                                            margin: EdgeInsets.only(
                                                                right: Dimensions
                                                                        .width10 /
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .circular(Dimensions
                                                                          .radius15 /
                                                                      2),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                  order
                                                                      .products[
                                                                          indes]
                                                                      .images[0],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Dimensions.height20 * 4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        children: [
                                                          BigText(
                                                            text: 'total:',
                                                            size: 16,
                                                            color: AppColors
                                                                .titleColor,
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                  .width10),
                                                          BigText(
                                                            text: '\$${order.totalPrice.toString()}'
                                                                .toString(),
                                                            size: 16,
                                                            color: AppColors
                                                                .titleColor,
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => Get.toNamed(
                                                          Routes.ORDER_DETAILS,
                                                          arguments: order,
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions.width10,
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                        .radius15 /
                                                                    3),
                                                            border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .mainColor,
                                                            ),
                                                          ),
                                                          child: SmallText(
                                                            text: 'Details',
                                                            color:
                                                                AppColors.mainColor,
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
                        )
                      : const Expanded(child: CustomLoader())
                  : const Expanded(
                      child: NoDataPage(
                        text: "Order's list is Empty",
                        imgPath: AppString.ASSETS_EMPTY,
                      ),
                    ),
            ],
          );
      }
    );
  }
}
