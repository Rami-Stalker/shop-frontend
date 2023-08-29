import 'package:get/get.dart';
import 'package:shop_app/src/modules/search/repositories/search_repository.dart';

import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchRepository>(
      () => SearchRepository(baseRepository: Get.find()),
    );
    Get.lazyPut<SearchControlle>(
      () => SearchControlle(searchRepository: Get.find()),
    );
  }
}
