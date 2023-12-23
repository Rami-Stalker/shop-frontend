import 'package:shop_app/src/modules/menu/views/menu_view.dart';

import '../../../controller/app_controller.dart';
import '../../../services/socket/socket.dart';
import '../../analytics/views/analtyics_view.dart';
import '../../cart/views/cart_history_view.dart';
import '../../home/views/home_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_admin/views/home_admin_view.dart';
import '../../order/views/order_view.dart';
import '../../settings/views/settings_view.dart';

class NavigatorUserController extends GetxController {
  final List<Widget> _userPages = [
    const HomeView(),
    const MenuView(),
    const OrderView(),
    const CartHistoryView(),
    const SettingsView(),
  ];
  List<Widget> get userPages => _userPages;

  final List<Widget> _adminPages = [
    const HomeAdminView(),
    const MenuView(),
    const AnalyticsView(),
    const OrderView(),
    const SettingsView(),
  ];
  List<Widget> get adminPages => _adminPages;

  final Map<String, IconData> _items = {
    'home': Icons.home_outlined,
    'menu': Icons.menu,
    'order': Icons.archive,
    'cart': Icons.shopping_cart,
    'me': Icons.person,
  };
  Map<String, IconData> get item => _items;

  final Rx<int> _currentIndex = 0.obs;
  Rx<int> get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    if (AppGet.authGet.onAuthCheck()) {
      AppGet.authGet.GetInfoUser();
      connectAndListen();
    }
  }
}
