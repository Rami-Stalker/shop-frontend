import 'package:get/get.dart';
import 'package:shop_app/src/app.dart';
import 'package:shop_app/src/modules/splash/views/splash_view.dart';
import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/edit_product/bindings/edit_product_binding.dart';
import '../modules/home/views/home_notifications.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/edit_product/views/edit_product_view.dart';
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
import '../modules/product_details/views/newest_product_view.dart';
import '../modules/product_details/views/rating_product_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/address_view.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NAVIGATION;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => Navigation(initialIndex: 0),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const HomeNotification(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CatigoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUCT,
      page: () => const EditProductView(),
      binding: EditProductBinding(),
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
      page: () => const NewestProductView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS_RATING,
      page: () => const RatingProductView(),
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
}
