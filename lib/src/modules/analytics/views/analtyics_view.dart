import 'package:flutter/material.dart';

import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/widgets/custom_loader.dart';
import '../../../models/sales_model.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({Key? key}) : super(key: key);

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  int? totalSales;
  List<Sales>? earnings;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
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
        title: AppText('Analtycs'),
      ),
      body: earnings != null || totalSales != null
          ? Padding(
              padding: EdgeInsets.all(15.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppText(
                    'total sales: \$$totalSales'
                  ),
                  SizedBox(height: 10.sp),
                  SizedBox(
                    height: 360.sp,
                    child: SfCartesianChart(
                      title: ChartTitle(text: 'Half yearly sales analysis'),
                      tooltipBehavior: _tooltipBehavior,
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        LineSeries<Sales, String>(
                          dataSource: earnings ?? [],
                          xValueMapper: (Sales sales, _) => sales.label,
                          yValueMapper: (Sales sales, _) => sales.earning,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const CustomLoader(),
    );
  }
}
