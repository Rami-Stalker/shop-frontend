
import 'package:shop_app/src/core/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/modules/admin/controllers/admin_controller.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../models/admin_model.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({Key? key}) : super(key: key);

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  AdminController adminCtrl = Get.find<AdminController>();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminCtrl.fetchEarnings();
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const CustomLoader()
        : Column(
            children: [
              SizedBox(
                height: 70.sp,
              ),
              Text(
                'total sales: \$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Dimensions.height10
              ),
              // SizedBox(
              //   height: Dimensions.screenHeight - 170,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: AppColors.mainColor,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(Dimensions.radius15),
              //         topRight: Radius.circular(Dimensions.radius15),
              //         )
              //     ),
              //     child: CategoryProductsChart(seriesList: [
              //       charts.Series(
              //         id: 'Sales',
              //         data: earnings!,
              //         domainFn: (Sales sales, _) => sales.label,
              //         measureFn: (Sales sales, _) => sales.earning,
              //       ),
              //     ]),
              //   ),
              // )
            ],
          );
  }
}
