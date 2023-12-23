import 'package:get/get.dart';
import 'package:shop_app/src/modules/auth/bindings/auth_binding.dart';
import 'package:shop_app/src/modules/auth/views/login_view.dart';
import 'package:shop_app/src/modules/auth/views/register_view.dart';
import 'package:shop_app/src/modules/cart/bindings/cart_binding.dart';
import 'package:shop_app/src/modules/cart/views/cart_view.dart';
import 'package:shop_app/src/modules/category/bindings/category_binding.dart';
import 'package:shop_app/src/modules/checkout/bindings/checkout_binding.dart';
import 'package:shop_app/src/modules/checkout/views/checkout_view.dart';
import 'package:shop_app/src/modules/favorite/bindings/favorite_binding.dart';
import 'package:shop_app/src/modules/favorite/views/favorite_view.dart';
import 'package:shop_app/src/modules/language/views/language_view.dart';
import 'package:shop_app/src/modules/navigator/bindings/navigation_binding.dart';
import 'package:shop_app/src/modules/navigator/views/navigation_view.dart';
import 'package:shop_app/src/modules/notification/bindings/notification_binding.dart';
import 'package:shop_app/src/modules/notification/views/notification_view.dart';
import 'package:shop_app/src/modules/order_details/bindings/order_details_binding.dart';
import 'package:shop_app/src/modules/order_details/views/order_details_view.dart';
import 'package:shop_app/src/modules/product_add/bindings/product_add_binding.dart';
import 'package:shop_app/src/modules/product_details/bindings/product_details_binding.dart';
import 'package:shop_app/src/modules/product_edit/bindings/product_edit_binding.dart';
import 'package:shop_app/src/modules/profile_edit/bindings/profile_edit_binding.dart';
import 'package:shop_app/src/modules/profile_edit/views/address_view.dart';
import 'package:shop_app/src/modules/profile_edit/views/profile_edit_view.dart';
import 'package:shop_app/src/modules/search/bindings/product_search_binding.dart';
import 'package:shop_app/src/modules/settings/bindings/settings_binding.dart';
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
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.NAVIGATION,
      page: () => Navigation(),
      binding: NavigationBinding(),
      transition: Transition.fadeIn,
    ),

    // Notification
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.SEARCH_PRODUCT,
      page: () => ProductSearchView(),
      binding: ProductSearchBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.CATEGORY_PRODUCT,
      page: () => CatigoryView(),
      binding: CategoryBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.DETAILS_PRODUCT_RATING,
      page: () => ProductDetailsRatingView(),
      binding: ProductDetailsBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.DETAILS_PRODUCT_NEWEST,
      page: () => ProductDetailsNewestView(),
      binding: ProductDetailsBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.CREATE_PRODUCT,
      page: () => ProductAddView(),
      binding: ProductAddBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.EDIT_PRODUCT,
      page: () => ProductEditView(),
      binding: ProductEditBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.DETAILS_ORDER,
      page: () => OrderDetailsView(),
      arguments: {},
      binding: OrderDetailsBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.EDIT_INFO_USER,
      page: () => EditInfoView(),
      binding: ProfileEditBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddressView(),
      binding: ProfileEditBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.fadeIn,
    ),

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
