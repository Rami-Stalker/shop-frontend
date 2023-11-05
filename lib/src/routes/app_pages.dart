import 'package:get/get.dart';
import 'package:shop_app/src/modules/auth/views/login_view.dart';
import 'package:shop_app/src/modules/auth/views/register_view.dart';
import 'package:shop_app/src/modules/cart/views/cart_view.dart';
import 'package:shop_app/src/modules/checkout/views/checkout_view.dart';
import 'package:shop_app/src/modules/favorite/views/favorite_view.dart';
import 'package:shop_app/src/modules/language/views/language_view.dart';
import 'package:shop_app/src/modules/navigator/views/navigation_view.dart';
import 'package:shop_app/src/modules/notification/views/notification_view.dart';
import 'package:shop_app/src/modules/order_details/views/order_details_view.dart';
import 'package:shop_app/src/modules/profile_edit/views/address_view.dart';
import 'package:shop_app/src/modules/profile_edit/views/profile_edit_view.dart';
import 'package:shop_app/src/modules/settings/views/settings_view.dart';
import 'package:shop_app/src/modules/splash/views/splash_view.dart';

import '../modules/category/views/category_view.dart';
import '../modules/product_add/views/product_add_view.dart';
import '../modules/product_details/views/product_details_newest_view.dart';
import '../modules/product_details/views/product_details_rating_view.dart';
import '../modules/product_edit/views/product_edit_view.dart';
import '../modules/search/views/product_search_view.dart';

part 'app_routes.dart';

class AppNavigator {
  AppNavigator._();

  Map<String, dynamic>? arguments;

  static final List<GetPage> routes = [
    // Splash
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      transition: Transition.fadeIn,
    ),

    // Navication
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => Navigation(),
      transition: Transition.fadeIn,
    ),

    // Notification
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      transition: Transition.fadeIn,
    ),

    // Authintication
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      transition: Transition.fadeIn,
    ),

    // Product
    GetPage(
      name: _Paths.SEARCH_PRODUCT,
      page: () => ProductSearchView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CATEGORY_PRODUCT,
      page: () => CatigoryView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DETAILS_PRODUCT_RATING,
      page: () => ProductDetailsRatingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DETAILS_PRODUCT_NEWEST,
      page: () => ProductDetailsNewestView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CREATE_PRODUCT,
      page: () => ProductAddView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.EDIT_PRODUCT,
      page: () => ProductEditView(),
      transition: Transition.fadeIn,
    ),

    // Cart
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      transition: Transition.fadeIn,
    ),

    // Check out
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      transition: Transition.fadeIn,
    ),

    // Order
    GetPage(
      name: _Paths.DETAILS_ORDER,
      page: () => OrderDetailsView(),
      arguments: {},
      transition: Transition.fadeIn,
    ),

    // User
    GetPage(
      name: _Paths.EDIT_INFO_USER,
      page: () => EditInfoView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddressView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      transition: Transition.fadeIn,
    ),

    // Settings
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      transition: Transition.fadeIn,
    ),

    // Language
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => LanguageView(),
      transition: Transition.fadeIn,
    ),
  ];

  static push<T>(
    String route, {
    Object? arguments,
  }) {
    return Get.toNamed(route, arguments: arguments);
  }

  static replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return Get.offAndToNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) => 
  Get.offNamedUntil(route, (route) => false);

  static void pop() {
    Get.back();
  }
}
