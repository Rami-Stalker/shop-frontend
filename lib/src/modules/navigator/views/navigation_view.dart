import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/modules/menu/views/menu_view.dart';

import 'package:shop_app/src/resources/local/user_local.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../public/constants.dart';
import '../../../services/socket/socket.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/blurhash.dart';
import '../../home_admin/views/home_admin_view.dart';
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
    const HomeAdminView(),
    const AnalyticsView(),
    const OrderView(),
    const ProfileView(),
  ];

  List<Widget> _userPages = [
    const HomeView(),
    const MenuView(),
    const OrderView(),
    const CartHistoryView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState;
    currentPage = widget.initialIndex;
    // Future.delayed(Duration(milliseconds: 800), () async {
    //   LanguageService().initialLanguage(context);
    // });
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
          child: UserLocal().getUserType() == "admin"
              ? Row(
                  children: [
                    _buildItemBottomBar(
                      PhosphorIcons.house,
                      PhosphorIcons.houseFill,
                      0,
                      'Home',
                    ),
                    _buildItemBottomBar(
                      Icons.analytics_outlined,
                      Icons.analytics_rounded,
                      1,
                      'Analtycs',
                    ),
                    _buildItemBottomBar(
                      PhosphorIcons.shoppingBag,
                      PhosphorIcons.shoppingBagFill,
                      2,
                      'Orders',
                    ),
                    
                    _buildItemBottomAccount(
                      AppGet.authGet.onAuthCheck()
                        ? (AppGet.authGet.userModel?.image ?? AppConstants.urlImageDefault)
                        : AppConstants.urlImageDefault,
                      AppGet.authGet.onAuthCheck() 
                        ? (AppGet.authGet.userModel?.blurHash ?? '') 
                        : '',
                      3,
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
                    !AppGet.authGet.onAuthCheck() ?
                    _buildItemBottom(
                      AppConstants.urlImageDefault,
                      AppConstants.urlImageDefault,
                      4,
                      '',
                    )
                    : _buildItemBottomAccount(
                      AppGet.authGet.onAuthCheck()
                        ? (AppGet.authGet.userModel?.image ?? AppConstants.urlImageDefault)
                        : AppConstants.urlImageDefault,
                      AppGet.authGet.onAuthCheck() 
                        ? (AppGet.authGet.userModel?.blurHash ?? '') 
                        : '',
                      4,
                    ),
                  ],
                ),
        ),
      ),
      body: UserLocal().getUserType() == "admin"
          ? _adminPages[currentPage]
          : _userPages[currentPage],
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
                      : colorBranch,
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

  Widget _buildItemBottom(inActiveIcon, activeIcon, index, title) {
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
                height: 18.5.sp,
                width: 18.5.sp,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                    index == currentPage ?
                    AssetImage(activeIcon)
                    : AssetImage(inActiveIcon),
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
                        color: currentPage == index
                            ? colorPrimary
                            : Colors.transparent,
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
