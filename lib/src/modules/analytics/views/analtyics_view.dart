import 'package:shop_app/src/controller/app_controller.dart';

import '../../../core/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../models/admin_model.dart';
import '../../../themes/app_colors.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({Key? key}) : super(key: key);

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await AppGet.analyticsGet.fetchEarnings();
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          'Analtycs',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: earnings != null || totalSales != null
          ? Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
                children: [
                  Text(
                    'total sales: \$$totalSales',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: Dimensions.height10),
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
              ),
          )
          : const CustomLoader(),
    );
  }
}
