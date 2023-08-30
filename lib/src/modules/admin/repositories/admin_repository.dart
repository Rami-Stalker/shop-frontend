import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/base_repository.dart';

import '../../../public/api_gateway.dart';
import '../../../models/product_model.dart';

class AdminRepository extends GetConnect {
  final BaseRepository baseRepository;
  AdminRepository({
    required this.baseRepository,
  });

  Future<diox.Response> fetchAllProducts() async {
    return await baseRepository.getRoute(ApiGateway.GET_PRODUCTS);
  }

  Future<diox.Response> deleteProduct({
    required ProductModel product,
  }) async {
    var body = {
      "id": product.id,
    };
    return await baseRepository.postRoute(
      ApiGateway.DELETE_PRODUCT,
      body,
    );
  }

  Future<diox.Response> updateProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
  }) async {
    var body = {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "quantity": quantity,
    };
    return await baseRepository.postRoute(
      ApiGateway.UPDATE_PRODUCT,
      body,
    );
  }
}
