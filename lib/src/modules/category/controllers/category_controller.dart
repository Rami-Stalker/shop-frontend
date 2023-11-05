import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import 'package:shop_app/src/modules/category/repositories/category_repository.dart';
import 'package:shop_app/src/public/components.dart';
import '../../../core/network/network_info.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepository categoryRepository;
  final NetworkInfo networkInfo;
  CategoryController({
    required this.categoryRepository,
    required this.networkInfo,
  });

  Future<List<ProductModel>?> fetchCategoryProduct({
    required String category,
  }) async {
    try {
      List<ProductModel>? productCategory = [];
    
    diox.Response response =
        await categoryRepository.fetchCategoryProduct(category: category);

    AppConstants.handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
            productCategory =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
      },
    );
    return productCategory;
    } catch (e) {
      Components.showSnackBar(title: "Category", e.toString());
      return [];
    }
  }
}
