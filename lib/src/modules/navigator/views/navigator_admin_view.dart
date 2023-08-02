import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/modules/navigator/controllers/navigator_admin_controller.dart';
class AdminNavigatorview extends GetView<NavigatorAdminController> {
  const AdminNavigatorview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: 
      Obx(
        () =>
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: controller.item.map(
            (lable, icon)=> MapEntry(
            lable, 
            BottomNavigationBarItem(
              icon: Icon(icon),
              label: lable,
              ),
            )).values.toList(),
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changePage(index);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          ),
      ),
        body: Obx(()=>controller.pages[controller.currentIndex.value],),
    );
  }
}