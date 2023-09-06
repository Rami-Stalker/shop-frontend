import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../public/components.dart';

import '../../../public/constants.dart';

import '../../../models/sales_model.dart';
import '../repositories/analytics_repository.dart';

class AnalyticsController extends GetxController implements GetxService {
  final AnalyticsRepository analyticsRepository;
  AnalyticsController({
    required this.analyticsRepository,
  });

  Future<Map<String, dynamic>> fetchEarnings() async {
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      diox.Response response = await analyticsRepository.fetchEarnings();

      Constants.handleApi(
        response: response,
        onSuccess: () {
          var rawData = response.data;
          totalEarning = rawData['totalEarnings'];
          sales = [
            Sales('Mobiles', rawData['mobileEarnings']),
            Sales('Essentials', rawData['essentialEarnings']),
            Sales('Books', rawData['booksEarnings']),
            Sales('Appliances', rawData['applianceEarnings']),
            Sales('Fashion', rawData['fashionEarnings']),
          ];
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
