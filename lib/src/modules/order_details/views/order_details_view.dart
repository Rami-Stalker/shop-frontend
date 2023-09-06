import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/public/components.dart';

import '../../../core/widgets/app_text_button.dart';
import '../controllers/order_details_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/order_model.dart';
import '../../../themes/app_decorations.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = AppGet.authGet.userModel!;
    OrderModel order = Get.arguments;
    controller.currentStep = order.status;
    return Scaffold(
      appBar: Components.customAppBar(
        context,
        "Details Order",
      ),
      body: ListView(
        padding: EdgeInsets.all(5.sp),
        physics: BouncingScrollPhysics(),
        children: [
          AppText('View order details'),
          SizedBox(height: 10.sp),
          _containerWidget(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoOrder(
                  context: context,
                  title: 'Order Date:',
                  subtitle: DateFormat("MM/dd/yyyy hh:mm a").format(
                    DateTime.fromMillisecondsSinceEpoch(
                      order.orderedAt,
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                _infoOrder(
                  context: context,
                  title: 'Order Id:',
                  subtitle: order.id,
                ),
                SizedBox(height: 10.sp),
                _infoOrder(
                  context: context,
                  title: 'Order Total:',
                  subtitle: '\$${order.totalPrice.toString()}',
                ),
              ],
            ),
          ),
          SizedBox(height: 20.sp),
          AppText('Purchase Details'),
          SizedBox(height: 10.sp),
          _containerWidget(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < order.products.length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 80.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.sp,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  order.products[i].images[0],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.sp),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.products[i].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 12.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Quality: ${order.quantity[i]}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 5.sp),
                      Divider(),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(height: 20.sp),
          AppText('Tracking'),
          SizedBox(height: 10.sp),
          _containerWidget(
            context,
            GetBuilder<OrderDetailsController>(
                builder: (orderDetailsController) {
              return Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: orderDetailsController.currentStep,
                controlsBuilder: (context, details) {
                  if (user.type == 'admin') {
                    return orderDetailsController.currentStep < 3
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: 10.sp,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppTextButton(
                                    txt: 'Done',
                                    onTap: () {
                                      orderDetailsController
                                          .changeOrderStatus(order.id);
                                      order.status++;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              top: 10.sp,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppTextButton(
                                    txt: 'Delete',
                                    onTap: () {
                                      AppGet.notificationGet.pushNotofication(
                                        userId: order.userId,
                                        title: "Order",
                                        message:
                                            "Your order ${order.id} \n is ready",
                                      );
                                      orderDetailsController.deleteOrder(
                                        order: order,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                  }
                  return const SizedBox();
                },
                steps: [
                  Step(
                    title: AppText(
                      'Pending',
                      type: TextType.small,
                    ),
                    content: AppText(
                      user.type == 'admin'
                          ? 'Order is yet to be delivered'
                          : 'Your order is yet to be delivered',
                      type: TextType.small,
                    ),
                    isActive: controller.currentStep > 0,
                    state: controller.currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: AppText(
                      'Completed',
                      type: TextType.small,
                    ),
                    content: AppText(
                      user.type == 'admin'
                          ? 'Order has been delivered, Custom are yet to sign.'
                          : 'Your order has been delivered, you are yet to sign.',
                      type: TextType.small,
                    ),
                    isActive: controller.currentStep > 1,
                    state: controller.currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: AppText(
                      'Received',
                      type: TextType.small,
                    ),
                    content: AppText(
                      user.type == 'admin'
                          ? 'Order has been delivered and signed by customer.'
                          : 'Your order has been delivered and signed by you.',
                      type: TextType.small,
                    ),
                    isActive: controller.currentStep > 2,
                    state: controller.currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: AppText(
                      'Delivered',
                      type: TextType.small,
                    ),
                    content: AppText(
                      user.type == 'admin'
                          ? 'Order has been delivered and signed by customer!'
                          : 'Your order has been delivered and signed by you!',
                      type: TextType.small,
                    ),
                    isActive: controller.currentStep >= 3,
                    state: controller.currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Row _infoOrder({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12.sp,
              ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12.sp,
              ),
        ),
      ],
    );
  }

  Container _containerWidget(
    BuildContext context,
    Widget child,
  ) {
    return Container(
      padding: EdgeInsets.all(
        10.sp,
      ),
      decoration: AppDecoration.textfeild(context, 5.sp).decoration,
      child: child,
    );
  }
}
