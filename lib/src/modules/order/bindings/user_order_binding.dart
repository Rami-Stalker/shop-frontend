import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class UserOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(Get.find()),
    );
  }
}
