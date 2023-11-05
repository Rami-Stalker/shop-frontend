import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/modules/category/controllers/category_controller.dart';
import 'package:shop_app/src/core/widgets/custom_shimmer_products.dart';

import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../core/widgets/product_widget.dart';
import '../../../models/product_model.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Drinks'),
    Tab(text: 'Breakfast'),
    Tab(text: 'Wraps'),
    Tab(text: 'Brunch'),
    Tab(text: 'Burgers'),
    Tab(text: 'French Toast'),
    Tab(text: 'Sides'),
    Tab(text: 'Toasted Paninis'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print('dddddddddddddddd');
    print(myTabs.length);
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: AppText('Our Menu'),
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          isScrollable: true,
          labelColor: colorBranch,
          unselectedLabelColor: Color(0xFFffE4AC),
          indicatorSize: TabBarIndicatorSize.label,
          indicator: CircleTapIndicator(color: mC, radius: 4),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return GetBuilder<CategoryController>(builder: (categoryController) {
            return FutureBuilder<List<ProductModel>?>(
                future:
                    categoryController.fetchCategoryProduct(category: label),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            ProductModel product = snapshot.data![index];
                            return ProductWidget(
                              onTap: () {
                                  AppNavigator.push(
                                    AppRoutes.DETAILS_PRODUCT_RATING,
                                    arguments: {
                                      'product': product,
                                      'ratings': product.ratings,
                                    },
                                  );
                                },
                              product: product,
                              index: index,
                            );
                          }),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Expanded(
                      child: NoDataPage(
                        text: "Your cart history is empty",
                        imgPath: AppConstants.EMPTY_ASSET,
                      ),
                    );
                  }
                  return const Expanded(child: CustomShimmerProducts());
                });
          });
        }).toList(),
      ),
    );
  }
}

class CircleTapIndicator extends Decoration {
  final Color color;
  final double radius;
  CircleTapIndicator({
    required this.color,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  late double radius;
  _CirclePainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
