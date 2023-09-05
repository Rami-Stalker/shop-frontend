import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/app.dart';
import 'package:shop_app/src/modules/notification/bindings/notification_binding.dart';
import 'package:shop_app/src/modules/notification/views/notification_view.dart';
import 'package:shop_app/src/modules/splash/views/splash_view.dart';
import 'package:shop_app/src/routess/scaffold_wrapper.dart';
import '../modules/product_add/bindings/product_add_binding.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/product_edit/bindings/product_edit_binding.dart';
import '../modules/product_add/views/product_add_view.dart';
import '../modules/product_edit/views/product_edit_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/category/views/category_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/navigator/views/navigation_admin_view.dart';
import '../modules/navigator/views/navigation_view.dart';
import '../modules/order_details/bindings/order_details_binding.dart';
import '../modules/order_details/views/order_details_view.dart';
import '../modules/product_details/bindings/product_details_binding.dart';
import '../modules/product_details/views/product_details_newest_view.dart';
import '../modules/product_details/views/product_details_rating_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/address_view.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppNavigator {
  AppNavigator._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const INITIAL = Routes.NAVIGATION;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => ScaffoldWrapper(child: App()),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => ScaffoldWrapper(child: SplashScreen()),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => ScaffoldWrapper(child: Navigation(initialIndex: 0)),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => ScaffoldWrapper(child: LoginView()),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => ScaffoldWrapper(child: const RegisterView()),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => ScaffoldWrapper(child: const NotificationView()),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CatigoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_ADD,
      page: () => const ProductAddView(),
      binding: ProductAddBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_EDIT,
      page: () => const ProductEditView(),
      binding: ProductEditBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_NAVIGATOR,
      page: () => const AdminNavigatorview(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS_NEWEST,
      page: () => const ProductDetailsNewestView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS_RATING,
      page: () => const ProductDetailsRatingView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => const UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: UpdateProfileBinding(),
    ),
  ];
  static Future push<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  static Future replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) => state.popUntil(ModalRoute.withName(route));

  static void pop() {
    if (state.canPop()) {
      state.pop();
    }
  }

  static String currentRoute(context) => ModalRoute.of(context)!.settings.name!;

  static NavigatorState get state => navigatorKey.currentState!;
}
