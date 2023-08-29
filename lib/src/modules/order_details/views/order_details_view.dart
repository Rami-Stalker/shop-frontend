import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/models/user_model.dart';

import '../../../controller/notification_controller.dart';
import '../../../core/widgets/app_text_button.dart';
import '../controllers/order_details_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/order_model.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_decorations.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = AppGet.authGet.userModel!;
    OrderModel userOrder = Get.arguments;
    controller.currentStep.value = userOrder.status;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Details",
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
      body: ListView(
        padding: EdgeInsets.all(5.sp),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            'View order details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: Dimensions.height10),
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
                      userOrder.orderedAt,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                _infoOrder(
                  context: context,
                  title: 'Order Id:',
                  subtitle: userOrder.id,
                ),
                SizedBox(height: Dimensions.height10),
                _infoOrder(
                  context: context,
                  title: 'Order Total:',
                  subtitle: '\$${userOrder.totalPrice.toString()}',
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height20),
          Text(
            'Purchase Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: Dimensions.height10),
          _containerWidget(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < userOrder.products.length; i++)
                  Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: Row(
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
                                userOrder.products[i].images[0],
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
                                userOrder.products[i].name,
                                style:
                                    Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Quality: ${userOrder.quantity[i]}',
                                style:
                                    Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height20),
          Text(
            'Tracking',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: Dimensions.height10),
          _containerWidget(
            context,
            Obx(
              ()=> Stepper(
                    physics: const NeverScrollableScrollPhysics(),
                    currentStep: controller.currentStep.value,
                    controlsBuilder: (context, details) {
                      if (user.type == 'admin') {
                        return controller.currentStep < 3
                            ? Padding(
                              padding: EdgeInsets.only(
                                top: Dimensions.height10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppTextButton(
                                        txt: 'Done',
                                        onTap: () {
                                          controller.changeOrderStatus(
                                            userOrder.id
                                          );
                                        },
                                      ),
                                  ),
                                ],
                              ),
                            )
                            : Padding(
                              padding: EdgeInsets.only(
                                top: Dimensions.height10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppTextButton(
                                        txt: 'Delete',
                                        onTap: () {
                                          Get.find<NotificationController>()
                                              .pushNotofication(
                                            userId: userOrder.userId,
                                            title: "Order",
                                            message:
                                                "Your order ${userOrder.id} \n is ready",
                                          );
                                          controller.deleteOrder(
                                            order: userOrder,
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
                        title: Text(
                          'Pending',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        content: Text(
                          user.type == 'admin'
                              ? 'Order is yet to be delivered'
                              : 'Your order is yet to be delivered',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        isActive: controller.currentStep > 0,
                        state: controller.currentStep > 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text(
                          'Completed',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        content: Text(
                          user.type == 'admin'
                              ? 'Order has been delivered, Custom are yet to sign.'
                              : 'Your order has been delivered, you are yet to sign.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        isActive: controller.currentStep > 1,
                        state: controller.currentStep > 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text(
                          'Received',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        content: Text(
                          user.type == 'admin'
                              ? 'Order has been delivered and signed by customer.'
                              : 'Your order has been delivered and signed by you.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        isActive: controller.currentStep > 2,
                        state: controller.currentStep > 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text(
                          'Delivered',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        content: Text(
                          user.type == 'admin'
                              ? 'Order has been delivered and signed by customer!'
                              : 'Your order has been delivered and signed by you!',
                              style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        isActive: controller.currentStep >= 3,
                        state: controller.currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Row _infoOrder(
      {required BuildContext context,
      required String title,
      required String subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13.sp),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13.sp),
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
        Dimensions.height10,
      ),
      decoration: AppDecoration.textfeild(context, 5.sp).decoration,
      child: child,
    );
  }
}
