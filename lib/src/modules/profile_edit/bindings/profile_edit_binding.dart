import 'package:get/get.dart';
import 'package:shop_app/src/modules/profile_edit/repositories/profile_edit_repository.dart';

import '../controllers/profile_edit_controller.dart';

class ProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditRepository>(
      () => ProfileEditRepository(Get.find()),
    );
    Get.lazyPut<ProfileEditController>(
      () => ProfileEditController(Get.find()),
    );
  }
}
