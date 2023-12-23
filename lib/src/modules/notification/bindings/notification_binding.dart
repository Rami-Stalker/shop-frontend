import 'package:get/get.dart';
import 'package:shop_app/src/modules/notification/controllers/notification_controller.dart';
import 'package:shop_app/src/modules/notification/repositories/notification_repository.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRepository>(
      () => NotificationRepository(Get.find()),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(Get.find()),
    );
  }
}
