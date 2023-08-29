
import 'package:shop_app/src/core/api/base_repository.dart';

import '../../../public/api_gateway.dart';

import 'package:dio/dio.dart' as diox;


class CategoryRepository {
  final BaseRepository baseRepository;
  CategoryRepository({
    required this.baseRepository,
  });

  Future<diox.Response> fetchCategoryProduct({
    required String category,
  }) async {
    return await baseRepository.getRoute('${ApiGateway.GET_CATEGORY}$category');
  }
}
