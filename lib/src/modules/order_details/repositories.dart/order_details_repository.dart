import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/base_repository.dart';

import '../../../models/order_model.dart';
import '../../../public/api_gateway.dart';

class OrderDetailsRepository {
  final BaseRepository baseRepository;
  OrderDetailsRepository({
    required this.baseRepository,
  });

  Future<diox.Response> changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    var body = {
      "id": order.id,
      "status": status,
    };
    return await baseRepository.postRoute(
      ApiGateway.CHANGE_ORDER_STATUS,
      body,
    );
  }

  Future<diox.Response> deleteOrder({
    required OrderModel order,
  }) async {
    var body = {
      "id": order.id,
    };
    return await baseRepository.postRoute(
      ApiGateway.DELETE_ORDER,
      body,
    );
  }
}
