import 'package:get/get.dart';
import 'package:shop_app/src/modules/order_details/repositories/order_details_repository.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsRepository>(
      () => OrderDetailsRepository(Get.find()),
    );
    Get.lazyPut<OrderDetailsController>(
      () => OrderDetailsController(Get.find()),
    );
  }
}
