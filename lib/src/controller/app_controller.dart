import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_app/src/modules/notification/repositories/notification_repository.dart';
import 'package:shop_app/src/resources/base_repository.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';

import '../core/network/network_info.dart';
import '../modules/product_add/controllers/product_add_controller.dart';
import '../modules/home_admin/controllers/home_admin_controller.dart';
import '../modules/home_admin/repositories/home_admin_repository.dart';
import '../modules/analytics/controllers/analytics_controller.dart';
import '../modules/analytics/repositories/analytics_repository.dart';
import '../modules/auth/repositories/auth_repository.dart';
import '../modules/cart/controllers/cart_controller.dart';
import '../modules/cart/repositories/cart_repository.dart';
import '../modules/category/controllers/category_controller.dart';
import '../modules/checkout/controllers/checkout_controller.dart';
import '../modules/product_edit/controllers/product_edit_controller.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/repositories/home_repository.dart';
import '../modules/notification/controllers/notification_controller.dart';
import '../modules/order/controllers/order_controller.dart';
import '../modules/order/repositories/order_repository.dart';
import '../modules/order_details/controllers/order_details_controller.dart';
import '../modules/product_details/controllers/product_details_controller.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/search/controllers/search_controller.dart';
import '../modules/update_profile/controllers/update_profile_controller.dart';
import 'theme_controller.dart';

class AppGet {
  static final themeGet = Get.find<ThemeController>();
  static final notificationGet = Get.find<NotificationController>();
  static final authGet = Get.find<AuthController>();
  static final homeGet = Get.find<HomeController>();
  static final categoryGet = Get.find<CategoryController>();
  static final adminGet = Get.find<AdminController>();
  static final addProductGet = Get.find<ProductAddController>();
  static final editProduct = Get.find<ProductEditController>();
  static final analyticsGet = Get.find<AnalyticsController>();
  static final productDetailsGet = Get.find<ProductDetailsController>();
  static final CartGet = Get.find<CartController>();
  static final SearchGet = Get.find<SearchControlle>();
  static final checkoutGet = Get.find<CheckoutController>();
  static final profileGet = Get.find<ProfileController>();
  static final updateProfileGet = Get.find<UpdateProfileController>();
  static final orderGet = Get.find<OrderController>();
  static final orderDetailsGet = Get.find<OrderDetailsController>();

  static void init() {
    // base repository
    Get.lazyPut(() => BaseRepository());

    // netInfo
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
    Get.lazyPut(() => InternetConnectionChecker());

    //repos
    Get.lazyPut(() => NotificationRepository(baseRepository: Get.find()));
    Get.lazyPut(() => AuthRepository(baseRepository: Get.find()));
    Get.lazyPut(() => HomeRepository(baseRepository: Get.find()));
    Get.lazyPut(() => OrderRepository(baseRepository: Get.find()));
    Get.lazyPut(() => CartRepository());
    Get.lazyPut(() => AdminRepository(baseRepository: Get.find()));
    Get.lazyPut(() => AnalyticsRepository(baseRepository: Get.find()));

    //controllers
    Get.lazyPut(() => NotificationController(notificationRepository: Get.find()));
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => AuthController(authRepository: Get.find()));
    Get.lazyPut(() =>
        HomeController(homeRepository: Get.find(), networkInfo: Get.find()));
    Get.lazyPut(() => OrderController(orderRepository: Get.find()));
    Get.lazyPut(() => CartController(cartRepository: Get.find()));
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AdminController(adminRepository: Get.find()));
    Get.lazyPut(() => AnalyticsController(analyticsRepository: Get.find()));
  }

  static void dispose() {
    themeGet.dispose;
    notificationGet.dispose;
    authGet.dispose;
    homeGet.dispose;
    categoryGet.dispose;
    adminGet.dispose;
    addProductGet.dispose;
    editProduct.dispose;
    analyticsGet.dispose;
    productDetailsGet.dispose;
    CartGet.dispose;
    SearchGet.dispose;
    checkoutGet.dispose;
    profileGet.dispose;
    updateProfileGet.dispose;
    orderGet.dispose;
    orderDetailsGet.dispose;
  }

  ///Singleton factory
  static final AppGet _instance = AppGet._internal();

  factory AppGet() {
    return _instance;
  }

  AppGet._internal();
}
