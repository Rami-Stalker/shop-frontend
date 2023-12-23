import 'package:get/get.dart';
import 'package:shop_app/src/modules/product_details/repositories/product_detailes_repository.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsRepository>(
      () => ProductDetailsRepository(Get.find()),
    );
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(Get.find()),
    );
  }
}
