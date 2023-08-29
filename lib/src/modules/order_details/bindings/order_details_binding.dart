import 'package:get/get.dart';
import 'package:shop_app/src/modules/order_details/repositories.dart/order_details_repository.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsRepository>(
      () => OrderDetailsRepository(baseRepository: Get.find()),
    );
    Get.lazyPut<OrderDetailsController>(
      () => OrderDetailsController(orderDetailsRepository: Get.find()),
    );
  }
}
