import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/base_repository.dart';

import '../../../public/api_gateway.dart';

class OrderRepository {
  final BaseRepository baseRepository;
  OrderRepository({
    required this.baseRepository,
  });

  Future<diox.Response> fetchAllOrders() async {
    return await baseRepository.getRoute(ApiGateway.GET_ORDERS);
  }

  Future<diox.Response> fetchUserOrder() async {
    return await baseRepository.getRoute(ApiGateway.GET_ORDERS_BY_ID);
  }
}
