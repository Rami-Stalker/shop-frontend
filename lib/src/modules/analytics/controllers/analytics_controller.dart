import 'dart:convert';

import '../../../public/components.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../public/constants.dart';

import '../../../models/admin_model.dart';
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
      http.Response res = await analyticsRepository.fetchEarnings();

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
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
