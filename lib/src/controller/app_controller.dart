import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/src/lang/language_service.dart';
import 'package:shop_app/src/models/language_model.dart';
import 'package:shop_app/src/public/constants.dart';
import 'package:shop_app/src/resources/base_repository.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';

import '../core/network/network_info.dart';
import '../modules/auth/repositories/auth_repository.dart';
import '../modules/cart/repositories/cart_repository.dart';
import '../modules/favorite/controllers/favorite_controller.dart';
import '../modules/notification/repositories/notification_repository.dart';
import '../modules/product_add/controllers/product_add_controller.dart';
import '../modules/home_admin/controllers/home_admin_controller.dart';
import '../modules/analytics/controllers/analytics_controller.dart';
import '../modules/cart/controllers/cart_controller.dart';
import '../modules/category/controllers/category_controller.dart';
import '../modules/checkout/controllers/checkout_controller.dart';
import '../modules/product_edit/controllers/product_edit_controller.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/notification/controllers/notification_controller.dart';
import '../modules/order/controllers/order_controller.dart';
import '../modules/order_details/controllers/order_details_controller.dart';
import '../modules/product_details/controllers/product_details_controller.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/search/controllers/product_search_controller.dart';
import '../modules/profile_edit/controllers/profile_edit_controller.dart';
import 'theme_controller.dart';

class AppGet {
  static final themeGet = Get.find<ThemeController>();
  static final notificationGet = Get.find<NotificationController>();

  static final authGet = Get.find<AuthController>();

  static final homeGet = Get.find<HomeController>();
  static final adminGet = Get.find<HomeAdminController>();

  static final categoryGet = Get.find<CategoryController>();
  static final addProductGet = Get.find<ProductAddController>();
  static final editProduct = Get.find<ProductEditController>();
  static final analyticsGet = Get.find<AnalyticsController>();
  static final productDetailsGet = Get.find<ProductDetailsController>();
  static final CartGet = Get.find<CartController>();
  static final SearchGet = Get.find<ProductSearchController>();
  static final checkoutGet = Get.find<CheckoutController>();

  static final profileGet = Get.find<ProfileController>();
  static final updateProfileGet = Get.find<ProfileEditController>();
  static final favoriteGet = Get.find<FavoriteController>();

  static final orderGet = Get.find<OrderController>();
  static final orderDetailsGet = Get.find<OrderDetailsController>();

  static Future<Map<String, Map<String, String>>> init() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);

    Get.lazyPut<BaseRepository>(() => BaseRepository());

    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
    Get.lazyPut(() => InternetConnectionChecker());

    Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

    Get.lazyPut(() => AuthRepository(Get.find()));
    Get.lazyPut(() => AuthController(Get.find()));

    Get.lazyPut(() => NotificationRepository(Get.find()));
    Get.lazyPut(() => NotificationController(Get.find()));

    Get.lazyPut<CartRepository>(
      () => CartRepository(Get.find()),
    );
    Get.lazyPut<CartController>(
      () => CartController(Get.find()),
    );

    // Get.lazyPut(() => HomeRepository(Get.find()));
    // Get.lazyPut(() => HomeAdminRepository(Get.find()));

    // Get.lazyPut(() => ProductSearchRepository(baseRepository: Get.find()));
    // Get.lazyPut(() => CategoryRepository(baseRepository: Get.find()));
    // Get.lazyPut(() => ProductDetailsRepository(baseRepository: Get.find()));
    // Get.lazyPut(() => ProductAddRepository(baseRepository: Get.find()));
    // Get.lazyPut(() => ProductEditRepository(baseRepository: Get.find()));

    // Get.lazyPut(() => CartRepository(prefs: Get.find()));

    // Get.lazyPut(() => CheckoutRepository(baseRepository: Get.find()));

    // Get.lazyPut(() => OrderRepository(Get.find()));
    // Get.lazyPut(() => OrderDetailsRepository(baseRepository: Get.find()));

    // Get.lazyPut(() => ProfileEditRepository(baseRepository: Get.find()));
    // Get.lazyPut(() => FavoriteRepository(baseRepository: Get.find()));

    // Get.lazyPut(() => AnalyticsRepository(Get.find()));

    // //controllers
    // Get.lazyPut(() => NotificationController(notificationRepository: Get.find()));
    // Get.lazyPut(() => ThemeController());
    // Get.lazyPut(() => AuthController(authRepository: Get.find()));
    // Get.lazyPut(() =>
    //     HomeController(Get.find(), Get.find()));
    // Get.lazyPut(() => HomeAdminController(Get.find()));

    // Get.lazyPut(() => ProductSearchController(searchRepository: Get.find()));
    // Get.lazyPut(() => CategoryController(categoryRepository: Get.find(), networkInfo: Get.find()));
    // Get.lazyPut(() => ProductDetailsController(productDetailsRepository: Get.find()));
    // Get.lazyPut(() => ProductAddController(addProductRepository: Get.find()));
    // Get.lazyPut(() => ProductEditController(editProductRepository: Get.find()));
    // Get.lazyPut(() => CartController(cartRepository: Get.find()));

    // Get.lazyPut(() => CheckoutController(checkoutRepository: Get.find()));

    // Get.lazyPut(() => OrderController(Get.find()));
    // Get.lazyPut(() => OrderDetailsController(orderDetailsRepository: Get.find()));
    
    // Get.lazyPut(() => ProfileController());
    // Get.lazyPut(() => ProfileEditController(profileEditRepository: Get.find()));
    // Get.lazyPut(() => FavoriteController(favoriteRepository: Get.find()));

    // Get.lazyPut(() => AnalyticsController(Get.find()));

    Map<String, Map<String, String>> _languages = Map();
    for (LanguageModel languageModel in AppConstants.languages) {
      String jsonStringValues = await rootBundle.loadString('assets/languages/${languageModel.languageCode}.json');
      Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
      Map<String, String> _json = Map();
      _mappedJson.forEach((key, value) {
        _json[key] = value.toString();
      });
      _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
    }
    return _languages;
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
