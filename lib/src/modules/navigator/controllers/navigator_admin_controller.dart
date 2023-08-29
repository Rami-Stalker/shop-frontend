import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../analytics/views/analtyics_view.dart';
import '../../admin/views/products_view.dart';
import '../../order/views/order_view.dart';
import '../../profile/views/profile_view.dart';

class NavigatorAdminController extends GetxController {
  final List<Widget> _pages = [
    const ProductsView(),
    const AnalyticsView(),
    const OrderView(),
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
    List<String> i1 = [];
    List<int> i2 = [];
    i1.insertAll(2, ['ddd']);
    i2.removeWhere((element) => element % 2 == 0);
    i2.contains(2);
    i1.retainWhere((item) => item.length == 3);
    i1.sort((a, b) => a.length.compareTo(b.length));
  }

  @override
  void onInit() {
    super.onInit();
  }
}
