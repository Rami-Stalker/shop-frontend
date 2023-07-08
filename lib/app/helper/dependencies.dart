import 'package:shop_app/app/controller/notification_controller.dart';
import 'package:shop_app/app/controller/user_controller.dart';
import 'package:shop_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:shop_app/app/modules/admin/repositories/admin_repository.dart';
import 'package:shop_app/app/modules/admin_order/controllers/admin_order_controller.dart';
import 'package:shop_app/app/modules/admin_order/repositories/admin_order_repository.dart';
import 'package:shop_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/app/modules/auth/repositories/auth_repository.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/app/modules/cart/repositories/cart_repository.dart';
import 'package:shop_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:shop_app/app/modules/checkout/repositories/checkout_repository.dart';
import 'package:shop_app/app/modules/home/repositories/home_repository.dart';
import 'package:shop_app/app/modules/navigator/controllers/navigator_admin_controller.dart';
import 'package:shop_app/app/modules/navigator/controllers/navigator_user_controller.dart';
import 'package:shop_app/app/modules/user_order/controllers/user_order_controller.dart';
import 'package:shop_app/app/modules/user_order/repositories/user_order_repository.dart';
import 'package:shop_app/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:shop_app/app/modules/product_details/repositories/product_detailes_controller.dart';
import 'package:shop_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_app/app/modules/search/controllers/search_controller.dart';
import 'package:shop_app/app/modules/search/repositories/search_repository.dart';
import 'package:shop_app/app/modules/update_profile/controllers/update_profile_controller.dart';
import 'package:shop_app/app/modules/update_profile/repositories/update_profile_repository.dart';

import '../core/api/api_client.dart';
import '../modules/home/controllers/home_controller.dart';


Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //sharedPreferences
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  
  //repos
  Get.lazyPut(() => AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepository(apiClient: Get.find()));
  Get.lazyPut(() => UpdateProfileRepository(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => AdminRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ProductDetailsRepository(apiClient: Get.find()));
  Get.lazyPut(() => SearchRepository(apiClient: Get.find()));
  Get.lazyPut(() => CheckoutRepository(apiClient: Get.find()));
  Get.lazyPut(() => UserOrderRepository(apiClient: Get.find()));
  Get.lazyPut(() => AdminOrderRepository(apiClient: Get.find()));
  Get.lazyPut(() => UserOrderRepository(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => NotificationController(apiClient: Get.find()));
  Get.lazyPut(() => HomeController(homeRepository: Get.find()));
  Get.lazyPut(() => AuthController(apiClient: Get.find(), authRepository: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => NavigatorUserController());
  Get.lazyPut(() => NavigatorAdminController());
  Get.lazyPut(() => UpdateProfileController(updateProfileRepository: Get.find()));
  Get.lazyPut(() => AdminController(adminRepository: Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));
  Get.lazyPut(() => ProductDetailsController(productDetailsRepository: Get.find()));
  Get.lazyPut(() => SearchControlle(searchRepository: Get.find()));
  Get.lazyPut(() => CheckoutController(orderRepository: Get.find()));
  Get.lazyPut(() => UserOrderController(userOrderRepository: Get.find()));
  Get.lazyPut(() => ProfileController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AdminOrderController(adminOrderRepository: Get.find()));
  Get.lazyPut(() => UserOrderController(userOrderRepository: Get.find()));
}
