import 'package:get/get.dart';
import 'package:shop_app/src/modules/category/repositories/category_repository.dart';
import '../controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepository(baseRepository: Get.find()),
    );
    Get.lazyPut<CategoryController>(
      () => CategoryController(categoryRepository: Get.find(), networkInfo: Get.find()),
    );
  }
}
