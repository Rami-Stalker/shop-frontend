import 'package:dio/dio.dart' as diox;

import '../../../public/api_gateway.dart';

import '../../../resources/base_repository.dart';

class HomeRepository {
  final BaseRepository baseRepository;
  HomeRepository(
    this.baseRepository,
  );

  Future<diox.Response> fetchProductsTopRest() async {
    return await baseRepository.getRoute(ApiGateway.GET_PRODUCT_TOP_REST);
  }

  Future<diox.Response> fetchProductsMostPopular() async {
    return await baseRepository.getRoute(ApiGateway.GET_PRODUCT_MOST_POPULAR);
  }

  Future<diox.Response> fetchProductsMostRecent() async {
    return await baseRepository.getRoute(ApiGateway.GET_PRODUCT_MOST_RECENT);
  }

  Future<diox.Response> changeMealFavorite(String mealId) async {
    var body = {
      "mealId" : mealId,
    };
    return await baseRepository.postRoute(
      ApiGateway.FAVORITE_PRODUCT,
      body,
      );
  }
}
