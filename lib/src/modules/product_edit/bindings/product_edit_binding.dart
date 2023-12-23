import 'package:get/get.dart';
import 'package:shop_app/src/modules/product_edit/repositories/product_edit_repository.dart';
import '../controllers/product_edit_controller.dart';

class ProductEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductEditRepository>(
      () => ProductEditRepository(Get.find()),
    );
    Get.lazyPut<ProductEditController>(
      () => ProductEditController(Get.find()),
    );
  }
}
