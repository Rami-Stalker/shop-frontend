import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../repositories/search_repository.dart';

import '../../../public/components.dart';
import '../../../models/product_model.dart';
import '../../../public/constants.dart';

class SearchControlle extends GetxController implements GetxService {
  final SearchRepository searchRepository;
  SearchControlle({
    required this.searchRepository,
  });

  List<ProductModel> products = [];

  void changeSearchStatus(String query) async {
    if (query != '') {
      products = await fetchSearchProduct(
        searchQuery: query,
      );
    } else {
      products = [];
    }
    update();
  }

  Future<List<ProductModel>> fetchSearchProduct({
    required String searchQuery,
  }) async {
    List<ProductModel> products = [];
    try {
      diox.Response response =
          await searchRepository.fetchSearchProduct(searchQuery: searchQuery);

      Constants.handleApi(
        response: response,
        onSuccess: () {
        List rawData = response.data;
            products =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
        }
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
    return products;
  }
}
