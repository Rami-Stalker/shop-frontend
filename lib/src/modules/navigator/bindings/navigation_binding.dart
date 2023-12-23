import 'package:get/get.dart';
import 'package:shop_app/src/modules/analytics/controllers/analytics_controller.dart';
import 'package:shop_app/src/modules/analytics/repositories/analytics_repository.dart';
import 'package:shop_app/src/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/src/modules/cart/repositories/cart_repository.dart';
import 'package:shop_app/src/modules/home/controllers/home_controller.dart';
import 'package:shop_app/src/modules/home/repositories/home_repository.dart';
import 'package:shop_app/src/modules/home_admin/controllers/home_admin_controller.dart';
import 'package:shop_app/src/modules/home_admin/repositories/home_admin_repository.dart';
import 'package:shop_app/src/modules/navigator/controllers/navigator_user_controller.dart';
import 'package:shop_app/src/modules/order/controllers/order_controller.dart';
import 'package:shop_app/src/modules/order/repositories/order_repository.dart';
import 'package:shop_app/src/modules/settings/controllers/settings_controller.dart';
import 'package:shop_app/src/modules/settings/repositories/settings_repository.dart';
import 'package:shop_app/src/resources/base_repository.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseRepository>(
      () => BaseRepository(),
    );

    Get.lazyPut<NavigatorUserController>(
      () => NavigatorUserController(),
    );

    Get.lazyPut<HomeAdminRepository>(
      () => HomeAdminRepository(Get.find()),
    );
    Get.lazyPut<HomeAdminController>(
      () => HomeAdminController(Get.find()),
    );

    Get.lazyPut<AnalyticsRepository>(
      () => AnalyticsRepository(Get.find()),
    );
    Get.lazyPut<AnalyticsController>(
      () => AnalyticsController(Get.find()),
    );

    Get.lazyPut<OrderRepository>(
      () => OrderRepository(Get.find()),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(Get.find()),
    );

    Get.lazyPut<SettingsRepository>(
      () => SettingsRepository(Get.find()),
    );
    Get.lazyPut<SettingsCotnroller>(
      () => SettingsCotnroller(Get.find()),
    );
    
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(Get.find()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find(), Get.find()),
    );

    Get.lazyPut<CartRepository>(
      () => CartRepository(Get.find()),
    );
    Get.lazyPut<CartController>(
      () => CartController(Get.find()),
    );
  }
}
