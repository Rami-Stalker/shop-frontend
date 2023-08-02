import 'package:get/get.dart';

import '../controllers/user_order_controller.dart';

class UserOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserOrderController>(
      () => UserOrderController(userOrderRepository: Get.find()),
    );
  }
}
