import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/core/api/base_repository.dart';

import '../../../public/api_gateway.dart';

class AnalyticsRepository extends GetConnect {
  final BaseRepository baseRepository;
  AnalyticsRepository({
    required this.baseRepository,
  });

  Future<diox.Response> fetchEarnings() async {
    return await baseRepository.getRoute(ApiGateway.GET_EARNINGS);
  }
}
