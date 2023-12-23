import 'package:get/get.dart';
import 'package:shop_app/src/modules/settings/controllers/settings_controller.dart';
import 'package:shop_app/src/modules/settings/repositories/settings_repository.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(
      () => SettingsRepository(Get.find()),
    );
    Get.lazyPut<SettingsCotnroller>(
      () => SettingsCotnroller(Get.find()),
    );
  }
}
