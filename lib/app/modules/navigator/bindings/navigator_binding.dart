import 'package:get/get.dart';
import 'package:shop_app/app/modules/navigator/controllers/navigator_user_controller.dart';

class NavigatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatorUserController>(
      () => NavigatorUserController(),
    );
  }
}
