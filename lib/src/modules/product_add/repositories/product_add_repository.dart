import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/base_repository.dart';

import '../../../models/product_model.dart';
import '../../../public/api_gateway.dart';

class ProductAddRepository extends GetConnect {
  final BaseRepository baseRepository;
  ProductAddRepository({
    required this.baseRepository,
  });

  Future<diox.Response> addProduct({
    required ProductModel product,
  }) async {
    return await baseRepository.postRoute(
      ApiGateway.ADD_PRODUCT,
      product.toMap(),
    );
  }
}
