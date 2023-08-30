import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/base_repository.dart';

import '../../../public/api_gateway.dart';


class CheckoutRepository {
  final BaseRepository baseRepository;
  CheckoutRepository({
    required this.baseRepository,
  });

  Future<diox.Response> checkout({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    var body = {
      "productsId": productsId,
      "userQuants": userQuants,
      "totalPrice": totalPrice,
      "address": address,
    };
    return await baseRepository.postRoute(
      ApiGateway.ADD_ORDER,
      body,
    );
  }
}
