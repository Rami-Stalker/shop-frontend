import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/base_repository.dart';

import '../../../public/api_gateway.dart';

class SearchRepository {
  final BaseRepository baseRepository;
  SearchRepository({
    required this.baseRepository,
  });
  Future<diox.Response> fetchSearchProduct({
    required String searchQuery,
  }) async {
    return await baseRepository.getRoute(
      '${ApiGateway.GET_SEARCH}$searchQuery',
      );
  }
}
