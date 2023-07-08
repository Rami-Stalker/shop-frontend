import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/modules/search/repositories/search_repository.dart';

import '../../../core/utils/components/app_components.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../models/product_model.dart';

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
      http.Response res =
          await searchRepository.fetchSearchProduct(searchQuery: searchQuery);

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      update();
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
    return products;
  }
}
