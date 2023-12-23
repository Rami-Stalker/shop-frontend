import 'package:get/get.dart';
import 'package:shop_app/src/modules/product_add/repositories/product_add_repository.dart';
import '../controllers/product_add_controller.dart';

class ProductAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductAddRepository>(
      () => ProductAddRepository(Get.find()),
    );
    Get.lazyPut<ProductAddController>(
      () => ProductAddController(Get.find()),
    );
  }
}
