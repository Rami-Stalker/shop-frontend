import '../../cart/views/cart_history.dart';
import '../../home/views/home_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../order/views/order_view.dart';
import '../../profile/views/profile_view.dart';


class NavigatorUserController extends GetxController {
  final List<Widget> _pages = [
    const HomeView(),
    const OrderView(),
    const CartHistoryView(),
    const ProfileView(),
  ];
  List<Widget> get pages => _pages;

  final Map<String, IconData> _items = {
    'home': Icons.home_outlined,
    'history': Icons.archive,
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
  }
}
