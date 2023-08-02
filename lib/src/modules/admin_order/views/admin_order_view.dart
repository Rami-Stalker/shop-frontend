import 'package:shop_app/src/core/widgets/no_data_page.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/modules/admin_order/controllers/admin_order_controller.dart';
import 'package:shop_app/src/routes/app_pages.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/order_model.dart';
import '../../../public/constants.dart';

class AdminOrderView extends GetView<AdminOrderController> {
  const AdminOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminOrderController>(builder: (adminOrderController) {
      return Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: 100.sp,
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
                                    height: 120.sp,
                                    margin: EdgeInsets.only(
                                      bottom: Dimensions.height20,
                                    ),
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
                                                        height: 80.sp,
                                                        width: 80.sp,
                                                        margin: EdgeInsets.only(
                                                          right: 5.sp,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8.sp,
                                                          ),
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
                                              height: 80.sp,
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
                                                        size: 16.sp,
                                                        color: AppColors
                                                            .titleColor,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.width10,
                                                      ),
                                                      BigText(
                                                        text:
                                                            '\$${order.totalPrice.toString()}'
                                                                .toString(),
                                                        size: 16.sp,
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
                                                        vertical: 5.sp,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(5.sp),
                                                        border: Border.all(
                                                          width: 1.sp,
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
                    imgPath: Constants.EMPTY_ASSET,
                  ),
                ),
        ],
      );
    });
  }
}
