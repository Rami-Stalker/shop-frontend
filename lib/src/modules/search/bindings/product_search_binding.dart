import 'package:get/get.dart';
import 'package:shop_app/src/modules/search/repositories/product_search_repository.dart';

import '../controllers/product_search_controller.dart';

class ProductSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductSearchRepository>(
      () => ProductSearchRepository(baseRepository: Get.find()),
    );
    Get.lazyPut<ProductSearchController>(
      () => ProductSearchController(searchRepository: Get.find()),
    );
  }
}
