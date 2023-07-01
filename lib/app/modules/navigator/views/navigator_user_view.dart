
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/app/modules/navigator/controllers/navigator_user_controller.dart';

import '../../../core/utils/app_colors.dart';


class UserNavigatorView extends GetView<NavigatorUserController> {
  const UserNavigatorView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: Obx(
        () =>  BottomNavigationBar(
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
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          ),
      ),
        body: Obx(()=>controller.pages[controller.currentIndex.value],),
    );
  }
}