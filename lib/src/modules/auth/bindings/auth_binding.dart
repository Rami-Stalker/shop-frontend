import 'package:get/get.dart';
import 'package:shop_app/src/modules/auth/repositories/auth_repository.dart';
import 'package:shop_app/src/resources/base_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseRepository>(
      () => BaseRepository(),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(baseRepository: Get.find()),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(authRepository: Get.find()),
    );
  }
}
