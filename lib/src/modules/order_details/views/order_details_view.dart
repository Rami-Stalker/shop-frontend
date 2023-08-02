import 'package:shop_app/src/controller/notification_controller.dart';
import 'package:shop_app/src/controller/user_controller.dart';
import 'package:shop_app/src/modules/admin/controllers/admin_controller.dart';
import 'package:shop_app/src/modules/order_details/controllers/order_details_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/order_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_decorations.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({
    Key? key,
  }) : super(key: key);

  void navigateToSearchScreen(String query) {
    Get.toNamed(Routes.SEARCH, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    UserController userCtrl = Get.find<UserController>();
    OrderModel userOrder = Get.arguments;
    AdminController adminController = Get.find<AdminController>();
    adminController.currentStep = userOrder.status;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Details",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: AppDecoration.appbarIcon(context, 5.sp).decoration,
              child: Icon(Icons.arrow_back_ios, size: 10.sp),
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
      body: Column(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              child: ListView(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'View order details',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          Container(
                            padding: EdgeInsets.only(
                              right: Dimensions.width10,
                              left: Dimensions.width20,
                              top: Dimensions.width10,
                              bottom: Dimensions.width10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Order Date:'),
                                    Text(
                                        DateFormat("MM/dd/yyyy hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          userOrder.orderedAt),
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Order Id:'),
                                    Text(userOrder.id),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Order Total:'),
                                    Text(
                                        '\$${userOrder.totalPrice.toString()}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          const Text(
                            'Purchase Details',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          Container(
                            padding: EdgeInsets.only(
                              right: Dimensions.width10,
                              left: Dimensions.width20,
                              top: Dimensions.width10,
                              bottom: Dimensions.width10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < userOrder.products.length;
                                    i++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 100.sp,
                                            width: 100.sp,
                                            margin: EdgeInsets.only(
                                              right: 5.sp,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5.sp,
                                              ),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  userOrder
                                                      .products[i].images[0],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.sp),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userOrder.products[i].name,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Qty: ${userOrder.quantity[i]}',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          Text(
                            'Tracking',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          Container(
                            padding: EdgeInsets.only(
                              right: Dimensions.width10,
                              left: Dimensions.width20,
                              top: Dimensions.width10,
                              bottom: Dimensions.width10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: GetBuilder<AdminController>(
                                builder: (adminController) {
                              return Stepper(
                                currentStep: adminController.currentStep,
                                controlsBuilder: (context, details) {
                                  if (userCtrl.user.type == 'admin') {
                                    return adminController.currentStep < 3
                                        ? CustomButton(
                                            buttomText: 'Done',
                                            onPressed: () {
                                              adminController.changeOrderStatus(
                                                status: details.currentStep + 1,
                                                order: Get.arguments,
                                              );
                                            },
                                          )
                                        : CustomButton(
                                            buttomText: 'Delete',
                                            onPressed: () {
                                              Get.find<NotificationController>()
                                                  .pushNotofication(
                                                userId: userOrder.userId,
                                                title: "Order",
                                                body:
                                                    "Your order ${userOrder.id} \n is ready",
                                              );
                                              // controller.box.write("fcm", {
                                              //   "userId": userOrder.userId,
                                              //   "body": "Your order ${userOrder.id} \n is ready",
                                              // });
                                              adminController.deleteOrder(
                                                order: userOrder,
                                              );
                                            },
                                          );
                                  }
                                  return const SizedBox();
                                },
                                steps: [
                                  Step(
                                    title: const Text('Pending'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'
                                          ? 'Order is yet to be delivered'
                                          : 'Your order is yet to be delivered',
                                    ),
                                    isActive: adminController.currentStep > 0,
                                    state: adminController.currentStep > 0
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                  Step(
                                    title: const Text('Completed'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'
                                          ? 'Order has been delivered, Custom are yet to sign.'
                                          : 'Your order has been delivered, you are yet to sign.',
                                    ),
                                    isActive: adminController.currentStep > 1,
                                    state: adminController.currentStep > 1
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                  Step(
                                    title: const Text('Received'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'
                                          ? 'Order has been delivered and signed by customer.'
                                          : 'Your order has been delivered and signed by you.',
                                    ),
                                    isActive: adminController.currentStep > 2,
                                    state: adminController.currentStep > 2
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                  Step(
                                    title: const Text('Delivered'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'
                                          ? 'Order has been delivered and signed by customer!'
                                          : 'Your order has been delivered and signed by you!',
                                    ),
                                    isActive: adminController.currentStep >= 3,
                                    state: adminController.currentStep >= 3
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
