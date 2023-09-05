import '../../../routes/app_pages.dart';
import '../controllers/search_controller.dart';
import '../widgets/search_widget.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_icon.dart';

class SearchView extends GetView<SearchControlle> {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.products = [];
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: colorPrimary,
            width: double.maxFinite,
            height: 100.sp,
            padding: EdgeInsets.only(
              top: 45.sp,
              left: 10.sp,
              right: 10.sp,
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => AppNavigator.pop(),
                  icon: Icons.arrow_back_ios,
                ),
                SizedBox(width: 10.sp),
                GetBuilder<SearchControlle>(builder: (searchCtrl) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mCL,
                        borderRadius: BorderRadius.circular(15.sp),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: TextField(
                        autofocus: true,
                        onChanged: (val) {
                          searchCtrl.changeSearchStatus(val);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.sp),
                          hintText: "Search Products ...",
                          focusColor: colorMedium,
                          prefixIcon: Icon(
                            Icons.search,
                            color: colorMedium,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: mCL,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: mCL,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          GetBuilder<SearchControlle>(
            builder: (controller) => controller.products.isEmpty
                ? Container()
                : MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Expanded(
                      child: ListView(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              return SearchWidget(
                                product: controller.products[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
