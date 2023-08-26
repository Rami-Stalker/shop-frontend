import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/network/network_info.dart';
import '../../home/repositories/home_repository.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';

class CategoryController extends GetxController implements GetxService {
  final HomeRepository homeRepository;
  final NetworkInfo networkInfo;
  CategoryController({
    required this.homeRepository,
    required this.networkInfo,
  });

  List<ProductModel>? productCategory = [];

  Future<List<ProductModel>?> fetchCategoryProduct({
    required String category,
  }) async {
    http.Response res =
        await homeRepository.fetchCategoryProduct(category: category);

    Constants.httpErrorHandle(
      res: res,
      onSuccess: () {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          productCategory!.add(
            ProductModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
      },
    );
    return productCategory;
  }
}
