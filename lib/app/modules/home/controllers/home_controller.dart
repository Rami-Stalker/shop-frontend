import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/core/utils/components/app_components.dart';
import 'package:shop_app/app/modules/home/repositories/home_repository.dart';

import '../../../core/utils/constants/error_handling.dart';
import '../../../models/product_model.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepository homeRepository;
  HomeController({
    required this.homeRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel>? productCategory = [];
  List<ProductModel> productNewest = [];
  List<ProductModel> productRating = [];

  Future<List<ProductModel>?> fetchCategoryProduct({
    required String category,
  }) async {
    http.Response res =
        await homeRepository.fetchCategoryProduct(category: category);

    httpErrorHandle(
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

  Future<void> fetchRatingProduct() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepository.fetchRatingProduct();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productRating.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  )[i],
                ),
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }

  Future<void> fetchNewestProduct() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepository.fetchNewestProduct();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productNewest.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  )[i],
                ),
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }

  @override
  void onInit() {
    fetchNewestProduct();
    fetchRatingProduct();
    super.onInit();
  }
}
