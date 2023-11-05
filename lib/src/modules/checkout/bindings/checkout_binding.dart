import 'package:get/get.dart';
import 'package:shop_app/src/modules/checkout/repositories/checkout_repository.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutRepository>(
      () => CheckoutRepository(baseRepository: Get.find()),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(checkoutRepository: Get.find()),
    );
  }
}
