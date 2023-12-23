import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/public/api_gateway.dart';

import '../../../resources/base_repository.dart';

class ProductDetailsRepository {
  final BaseRepository baseRepository;
  ProductDetailsRepository(this.baseRepository);

  Future<diox.Response> rateProduct({
    required String productId,
    required double rating,
  }) async {
    var body = {
      "productId": productId,
      "rating": rating,
    };
    return await baseRepository.postRoute(
      ApiGateway.RATE_PRODUCT,
      body,
    );
  }
}
