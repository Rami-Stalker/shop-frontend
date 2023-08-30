import 'package:dio/dio.dart' as diox;

import '../../../public/api_gateway.dart';

import '../../../resources/base_repository.dart';

class HomeRepository {
  final BaseRepository baseRepository;
  HomeRepository({
    required this.baseRepository,
  });

  Future<diox.Response> fetchRatingProduct() async {
    return await baseRepository.getRoute(ApiGateway.GET_RATING);
  }

  Future<diox.Response> fetchNewestProduct() async {
    return await baseRepository.getRoute(ApiGateway.GET_NEWEST);
  }
}
