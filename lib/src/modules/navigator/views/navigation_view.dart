
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shop_app/src/services/socket/socket_io_service.dart';
// import '../controllers/navigator_user_controller.dart';

// class UserNavigatorView extends StatefulWidget {
//   const UserNavigatorView({super.key});

//   @override
//   State<UserNavigatorView> createState() => _UserNavigatorViewState();
// }

// class _UserNavigatorViewState extends State<UserNavigatorView> {
//   @override
//   void initState() {
//     connectAndListen();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () =>  BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           items: controller.item.map(
//             (lable, icon)=> MapEntry(
//             lable, 
//             BottomNavigationBarItem(
//               icon: Icon(icon),
//               label: lable,
//               ),
//             )).values.toList(),
//           currentIndex: controller.currentIndex.value,
//           onTap: (index) {
//             controller.changePage(index);
//           },
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           ),
//       ),
//         body: Obx(()=>controller.pages[controller.currentIndex.value],),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shop_app/src/controller/app_controller.dart';

import 'package:shop_app/src/resources/local/user_local.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../services/socket/socket.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/blurhash.dart';
import '../../admin/views/products_view.dart';
import '../../analytics/views/analtyics_view.dart';
import '../../cart/views/cart_history.dart';
import '../../home/views/home_view.dart';
import '../../order/views/order_view.dart';
import '../../profile/views/profile_view.dart';

class Navigation extends StatefulWidget {
  final int initialIndex;
  Navigation({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;

  List<Widget> _adminPages = [
    const ProductsView(),
    const AnalyticsView(),
    const OrderView(),
    const ProfileView(),
  ];

  List<Widget> _userPages = [
    const HomeView(),
    const OrderView(),
    const CartHistoryView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState;
    currentPage = widget.initialIndex;
    if (AppGet.authGet.onAuthCheck()) {
      AppGet.authGet.GetInfoUser();
      connectAndListen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          bottomNavigationBar: BottomAppBar(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: .0,
            child: Container(
              height: 48.sp,
              padding: EdgeInsets.symmetric(horizontal: 6.5.sp),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: .2,
                  ),
                ),
              ),
              child: UserLocal().getUserType() == "admin" ?
              Row(
                children: [
                  _buildItemBottomBar(
                    PhosphorIcons.house,
                    PhosphorIcons.houseFill,
                    0,
                    'Home',
                  ),
                  _buildItemBottomBar(
                    PhosphorIcons.shoppingBag,
                    PhosphorIcons.shoppingBagFill,
                    1,
                    'Classes',
                  ),
                  _buildItemBottomBar(
                    PhosphorIcons.shoppingCart,
                    PhosphorIcons.shoppingCartFill,
                    2,
                    'Message',
                  ),
                  _buildItemBottomBar(
                    PhosphorIcons.person,
                    PhosphorIcons.personFill,
                    2,
                    'Me',
                  ),
                ],
              ):
              Row(
                children: [
                  _buildItemBottomBar(
                    PhosphorIcons.house,
                    PhosphorIcons.houseFill,
                    0,
                    'Home',
                  ),
                  _buildItemBottomBar(
                    PhosphorIcons.shoppingBag,
                    PhosphorIcons.shoppingBagFill,
                    1,
                    'Classes',
                  ),
                  _buildItemBottomBar(
                    PhosphorIcons.shoppingCart,
                    PhosphorIcons.shoppingCartFill,
                    2,
                    'Message',
                  ),
                  _buildItemBottomAccount(
                    UserLocal().getAccessToken().isNotEmpty
                        ? AppGet.authGet.userModel!.photo
                        :'https://freepngimg.com/save/22654-man/594x600',
                        r'rGQ8#*9Z~D%2aL$+t6NHNG%NtQaKRkM_axo#oejF^Sr@I.S1S#S2o0n$WBROWWSyoexbj]nij]W;%Mg2NZV[i_nhWrt7t6xajFjbbbbvbbWAWAkD',
                    3,
                  ),
                ],
              ),
            ),
          ),
          body: UserLocal().getUserType() == "admin" ? _adminPages[currentPage] : _userPages[currentPage],
        );
  }

  Widget _buildItemBottomBar(inActiveIcon, activeIcon, index, title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentPage = index;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                child: Icon(
                  index == currentPage ? activeIcon : inActiveIcon,
                  size: 21.5.sp,
                  color: index == currentPage
                      ? colorPrimary
                      : Theme.of(context).textTheme.bodyMedium!.color,
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
    urlToImage,
    blurHash,
    index,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentPage = index;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 24.sp,
                    width: 24.sp,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentPage == index ? colorPrimary : Colors.transparent,
                        width: 1.8.sp,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.sp),
                      child: BlurHash(
                        hash: blurHash,
                        image: urlToImage,
                        imageFit: BoxFit.cover,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.sp),
              Container(
                height: 4.sp,
                width: 4.sp,
                decoration: BoxDecoration(
                  color: index == 2 ? colorPrimary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}