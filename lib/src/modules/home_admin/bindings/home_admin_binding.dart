import 'package:get/get.dart';

import '../controllers/home_admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(
      () => AdminController(adminRepository: Get.find()),
    );
  }
}
