import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/core/widgets/category_widget.dart';
import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/themes/app_decorations.dart';

import '../controllers/product_search_controller.dart';
import '../widgets/product_search_widget.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductSearchView extends StatefulWidget {
  const ProductSearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductSearchView> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ProductSearchView> {
  ProductSearchController searchController = AppGet.SearchGet;

  final List<String> categories = [
    "drinks",
    "breakfast",
    "wraps",
    "brunch",
    "burgers",
    "french toast",
    "sides",
    "toasted paninis",
  ];

  final List<int> prices = [
    20,
    40,
    60,
    80,
    100,
    150,
  ];

  List<int> selectedPrices = [];
  List<String> selectedCategories = [];

  double minPrice = 20;
  double maxPrice = 400;

  @override
  void initState() {
    super.initState();
    searchController.products.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.customAppBar(context, "Search"),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.sp),
            decoration:
                AppDecoration.productFavoriteCart(context, 5.sp).decoration,
            child: TextField(
              autofocus: true,
              onChanged: (val) {
                searchController.changeSearchStatus(val);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: "Search Products ...",
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                focusColor: colorBranch,
                prefixIcon: Icon(
                  Icons.search,
                  color: colorPrimary,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      builder: (BuildContext context) {
                        return Container(
                          height: 300,
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.sp),
                              topRight: Radius.circular(20.sp),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                colorPrimary,
                                colorBranch,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5.sp),
                              Obx(
                                () => Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: categories.map(
                                    (category) {
                                      return FilterChip(
                                        selected: searchController
                                            .selectedCategories
                                            .contains(category),
                                        label: Text(category),
                                        onSelected: (selected) {
                                          setState(() {
                                            if (selected) {
                                              searchController
                                                  .selectedCategories
                                                  .add(category);
                                            } else {
                                              searchController
                                                  .selectedCategories
                                                  .remove(category);
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(),
                              SizedBox(height: 5),
                              Obx(
                                () => RangeSlider(
                                  values: searchController.priceRange.value,
                                  activeColor: colorBranch,
                                  inactiveColor: colorBranch.withOpacity(0.5),
                                  min: 20,
                                  max: 400,
                                  onChanged: (RangeValues values) {
                                    searchController.updatePriceRange(values);
                                  },
                                ),
                              ),
                              Obx(
                                () => AppText(
                                  'Price Range: \$${searchController.priceRange.value.start.toInt()} - \$${searchController.priceRange.value.end.toInt()}',
                                ),
                              ),
                              SizedBox(height: 10.sp),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.filter_list, color: colorPrimary,),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.sp),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: mCL,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.sp),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: mCL,
                  ),
                ),
              ),
            ),
          ),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Obx(
                      () {
                        final filteredProducts = searchController
                            .filterProductsByPriceAndCategory(
                          priceRange: searchController.priceRange.value,
                        );

                        if (filteredProducts.isEmpty) {
                          return CategoryWidget();
                        }

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredProducts.length,
                          padding: EdgeInsets.fromLTRB(5.sp, 0, 5.sp, 5.sp),
                          itemBuilder: (context, index) {
                            return ProductSearchWidget(
                              product: filteredProducts[index],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
