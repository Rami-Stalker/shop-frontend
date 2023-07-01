import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/app/modules/admin/views/analtyics_view.dart';
import '../../admin/views/products_view.dart';
import '../../admin_order/views/admin_order_view.dart';
import '../../profile/views/profile_view.dart';

class NavigatorAdminController extends GetxController {
  final List<Widget> _pages = [
    const ProductsView(),
    const AnalyticsView(),
    const AdminOrderView(),
    const ProfileView(),
  ];
  List<Widget> get pages => _pages;

  final Map<String, IconData> _items = {
    'home': Icons.home_outlined,
    'analytics': Icons.analytics_outlined,
    'inbox': Icons.all_inbox_outlined,
    'profile': Icons.person,
  };
  Map<String, IconData> get item => _items;

  final Rx<int> _currentIndex = 0.obs;
  Rx<int> get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex.value = index;
  }
}
