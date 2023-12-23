import 'package:get/get.dart';
import 'package:shop_app/src/modules/cart/repositories/cart_repository.dart';

import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartRepository>(
      () => CartRepository(Get.find()),
    );

    Get.lazyPut<CartController>(
      () => CartController(Get.find()),
    );
  }
}
