import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/modules/navigator/controllers/navigator_user_controller.dart';

import 'package:shop_app/src/resources/local/user_local.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';

class Navigation extends GetView<NavigatorUserController> {
  final int initialIndex;
  Navigation({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: .0,
        child: Container(
          // height: 38.sp,
          // padding: EdgeInsets.symmetric(horizontal: 6.5.sp),
          // alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   border: Border(
          //     top: BorderSide(
          //       color: Theme.of(context).dividerColor,
          //       width: .2,
          //     ),
          //   ),
          // ),
          child: UserLocal().getUser()?.type == "admin"
              ? Row(
                  children: [
                    _buildItemBottomBar(
                      PhosphorIcons.house,
                      PhosphorIcons.houseFill,
                      0,
                      'Home',
                    ),
                    _buildItemBottom(
                      "assets/images/forkm.png",
                      "assets/images/forkp.png",
                      1,
                      'Menu',
                    ),
                    _buildItemBottomBar(
                      Icons.analytics_outlined,
                      Icons.analytics_rounded,
                      2,
                      'Analtycs',
                    ),
                    _buildItemBottomBar(
                      PhosphorIcons.shoppingBag,
                      PhosphorIcons.shoppingBagFill,
                      3,
                      'Orders',
                    ),
                    _buildItemBottomAccount(
                      AppGet.authGet.onAuthCheck()
                          ? (AppGet.authGet.userModel?.photo ??
                              AppConstants.urlImageDefaultPreson)
                          : AppConstants.urlImageDefaultPreson,
                      AppGet.authGet.onAuthCheck()
                          ? (AppGet.authGet.userModel?.blurHash ?? '')
                          : '',
                      4,
                    ),
                  ],
                )
              : Row(
                  children: [
                    _buildItemBottomBar(
                      PhosphorIcons.house,
                      PhosphorIcons.houseFill,
                      0,
                      'Home',
                    ),
                    _buildItemBottom(
                      "assets/images/forkm.png",
                      "assets/images/forkp.png",
                      1,
                      'Menu',
                    ),
                    _buildItemBottomBar(
                      PhosphorIcons.shoppingBag,
                      PhosphorIcons.shoppingBagFill,
                      2,
                      'Orders',
                    ),
                    _buildItemBottomBar(
                      PhosphorIcons.shoppingCart,
                      PhosphorIcons.shoppingCartFill,
                      3,
                      'Message',
                    ),
                    !AppGet.authGet.onAuthCheck()
                        ? _buildItemBottom(
                            AppConstants.urlImageDefault,
                            AppConstants.urlImageDefault,
                            4,
                            '',
                          )
                        :
                    _buildItemBottomAccount(
                      AppGet.authGet.onAuthCheck()
                          ? (AppGet.authGet.userModel?.photo ??
                              AppConstants.urlImageDefaultPreson)
                          : AppConstants.urlImageDefaultPreson,
                      AppGet.authGet.onAuthCheck()
                          ? (AppGet.authGet.userModel?.blurHash ?? '')
                          : '',
                      4,
                    ),
                  ],
                ),
        ),
      ),
      body: Obx(
        () => UserLocal().getUser()?.type == "admin"
            ? controller.adminPages[controller.currentIndex.value]
            : controller.userPages[controller.currentIndex.value],
      ),
    );
  }

  Widget _buildItemBottomBar(inActiveIcon, activeIcon, index, title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changePage(index);
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  color: Colors.transparent,
                  child: Icon(
                    index == controller.currentIndex.value
                        ? activeIcon
                        : inActiveIcon,
                    size: 21.5.sp,
                    color: index == controller.currentIndex.value
                        ? colorPrimary
                        : colorBranch,
                  ),
                ),
              ),
              // SizedBox(height: 2.5.sp),
              // Container(
              //   height: 4.sp,
              //   width: 4.sp,
              //   decoration: BoxDecoration(
              //     color: index == 10 ? colorPrimary : Colors.transparent,
              //     shape: BoxShape.circle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemBottom(inActiveIcon, activeIcon, index, title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changePage(index);
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  height: 18.5.sp,
                  width: 18.5.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: index == controller.currentIndex.value
                          ? AssetImage(activeIcon)
                          : AssetImage(inActiveIcon),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.5.sp),
              Container(
                height: 4.sp,
                width: 4.sp,
                decoration: BoxDecoration(
                  color: index == 10 ? colorPrimary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemBottomAccount(
    String urlToImage,
    String blurHash,
    int index,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changePage(index);
        },
        child: Center(
          child: Obx(
            ()=> Container(
              height: 25.sp,
              width: 25.sp,
              decoration: BoxDecoration(
                color: colorBranch,
                borderRadius: BorderRadius.circular(50.sp),
                border: Border.all(
                  color: controller.currentIndex.value == index
                      ? colorPrimary
                      : Colors.transparent,
                      width: 1.8.sp,
                ),
                image: DecorationImage(
                  image: NetworkImage(urlToImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   color: Colors.transparent,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Obx(
        //         ()=> Container(
        //               height: 24.sp,
        //               width: 24.sp,
        //               decoration: BoxDecoration(
        //                 border: Border.all(
        //                   color: controller.currentIndex.value == index
        //                       ? colorPrimary
        //                       : Colors.transparent,
        //                   width: 1.8.sp,
        //                 ),
        //                 shape: BoxShape.circle,
        //               ),
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(12.sp),
        //                 child: BlurHash(
        //                   hash: blurHash,
        //                   image: urlToImage,
        //                   imageFit: BoxFit.cover,
        //                   color: colorPrimary,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       // SizedBox(height: 2.5.sp),
        //       // Container(
        //       //   height: 4.sp,
        //       //   width: 4.sp,
        //       //   decoration: BoxDecoration(
        //       //     color: index == 2 ? colorPrimary : Colors.transparent,
        //       //     shape: BoxShape.circle,
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
