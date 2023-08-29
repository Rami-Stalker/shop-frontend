import 'package:get/get.dart';
import 'package:shop_app/src/modules/update_profile/repositories/update_profile_repository.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProfileRepository>(
      () => UpdateProfileRepository(baseRepository: Get.find()),
    );
    Get.lazyPut<UpdateProfileController>(
      () => UpdateProfileController(updateProfileRepository: Get.find()),
    );
  }
}
