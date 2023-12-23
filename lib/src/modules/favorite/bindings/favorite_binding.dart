import 'package:get/get.dart';
import 'package:shop_app/src/modules/favorite/controllers/favorite_controller.dart';
import 'package:shop_app/src/modules/favorite/repositories/favorite_repository.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteRepository>(
      () => FavoriteRepository(Get.find()),
    );

    Get.lazyPut<FavoriteController>(
      () => FavoriteController(Get.find()),
    );
  }
}
