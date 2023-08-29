// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:shop_app/src/config/application.dart';
// import 'package:shop_app/src/controller/application_controller.dart';
// import 'package:shop_app/src/controller/theme_controller.dart';
// import 'controller/notification_controller.dart';
// import 'modules/add_product/controllers/add_product_controller.dart';
// import 'modules/add_product/repositories/add_product_repository.dart';
// import 'modules/admin/controllers/admin_controller.dart';
// import 'modules/admin/repositories/admin_repository.dart';
// import 'modules/analytics/controllers/analytics_controller.dart';
// import 'modules/analytics/repositories/analytics_repository.dart';

// import 'package:get/get.dart';
// import 'modules/auth/controllers/auth_controller.dart';
// import 'modules/auth/repositories/auth_repository.dart';
// import 'modules/cart/controllers/cart_controller.dart';
// import 'modules/cart/repositories/cart_repository.dart';
// import 'modules/category/controllers/category_controller.dart';
// import 'modules/category/repositories/category_repository.dart';
// import 'modules/checkout/controllers/checkout_controller.dart';
// import 'modules/checkout/repositories/checkout_repository.dart';
// import 'modules/edit_product/controllers/edit_product_controller.dart';
// import 'modules/edit_product/repositories/edit_product_repository.dart';
// import 'modules/home/repositories/home_repository.dart';
// import 'modules/navigator/controllers/navigator_admin_controller.dart';
// import 'modules/navigator/controllers/navigator_user_controller.dart';
// import 'modules/order/controllers/order_controller.dart';
// import 'modules/order/repositories/order_repository.dart';
// import 'modules/order_details/controllers/order_details_controller.dart';
// import 'modules/order_details/repositories.dart/order_details_repository.dart';
// import 'modules/product_details/controllers/product_details_controller.dart';
// import 'modules/product_details/repositories/product_detailes_repository.dart';
// import 'modules/profile/controllers/profile_controller.dart';
// import 'modules/search/controllers/search_controller.dart';
// import 'modules/search/repositories/search_repository.dart';
// import 'modules/update_profile/controllers/update_profile_controller.dart';
// import 'modules/update_profile/repositories/update_profile_repository.dart';

// import 'core/api/api_client.dart';
// import 'core/network/network_info.dart';
// import 'modules/home/controllers/home_controller.dart';


// Future<void> init() async {
//   //final sharedPreferences = await SharedPreferences.getInstance();

//   //sharedPreferences
//   //Get.lazyPut(() => sharedPreferences);

//   //api client
//   Get.lazyPut(() => ApiClient(Application.baseUrl));

//   // netInfo
//   Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
//   Get.lazyPut(() => InternetConnectionChecker());
  
//   //repos
//   Get.lazyPut(() => AuthRepository(apiClient: Get.find()));
//   Get.lazyPut(() => HomeRepository(apiClient: Get.find()));
//   Get.lazyPut(() => CategoryRepository(apiClient: Get.find()));
//   Get.lazyPut(() => UpdateProfileRepository(apiClient: Get.find(),sharedPreferences: Get.find()));
//   Get.lazyPut(() => AdminRepository(apiClient: Get.find()));
//   Get.lazyPut(() => CartRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => AddProductRepository(apiClient: Get.find()));
//   Get.lazyPut(() => EditProductRepository(apiClient: Get.find()));
//   Get.lazyPut(() => AnalyticsRepository(apiClient: Get.find()));
//   Get.lazyPut(() => ProductDetailsRepository(apiClient: Get.find()));
//   Get.lazyPut(() => SearchRepository(apiClient: Get.find()));
//   Get.lazyPut(() => CheckoutRepository(apiClient: Get.find()));
//   Get.lazyPut(() => OrderRepository(apiClient: Get.find()));
//   Get.lazyPut(() => OrderDetailsRepository(apiClient: Get.find()));

//   //controllers
//   Get.lazyPut(() => ApplicationController());
//   Get.lazyPut(() => ThemeController());
//   Get.lazyPut(() => NotificationController(apiClient: Get.find()));
//   Get.lazyPut(() => AuthController(loginRepository: Get.find()));
//   Get.lazyPut(() => NavigatorUserController());
//   Get.lazyPut(() => NavigatorAdminController());
//   Get.lazyPut(() => HomeController(homeRepository: Get.find(), networkInfo: Get.find()));
//   Get.lazyPut(() => CategoryController(categoryRepository: Get.find(), networkInfo: Get.find()));
//   Get.lazyPut(() => UpdateProfileController(updateProfileRepository: Get.find()));
//   Get.lazyPut(() => AdminController(adminRepository: Get.find()));
//   Get.lazyPut(() => CartController(cartRepository: Get.find()));
//   Get.lazyPut(() => AddProductController(addProductRepository: Get.find()));
//   Get.lazyPut(() => EditProductController(editProductRepository: Get.find()));
//   Get.lazyPut(() => AnalyticsController(analyticsRepository: Get.find()));
//   Get.lazyPut(() => ProductDetailsController(productDetailsRepository: Get.find()));
//   Get.lazyPut(() => SearchControlle(searchRepository: Get.find()));
//   Get.lazyPut(() => CheckoutController(orderRepository: Get.find()));
//   Get.lazyPut(() => ProfileController(sharedPreferences: Get.find()));
//   Get.lazyPut(() => OrderController(orderRepository: Get.find()));
//   Get.lazyPut(() => OrderDetailsController(orderDetailsRepository: Get.find()));
// }
