import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(apiClient: Get.find(), loginRepository: Get.find(), sharedPreferences: Get.find()),
    );
  }
}
