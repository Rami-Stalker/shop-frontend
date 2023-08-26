import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(apiClient: Get.find(), registerRepository: Get.find(), sharedPreferences: Get.find()),
    );
  }
}
