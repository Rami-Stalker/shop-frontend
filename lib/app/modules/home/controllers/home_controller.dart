import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
  List<ProductModel> productNew = [];
  List<ProductModel> productRating = [];
  // List<ProductModel>? productList;

  void fetchCategoryProduct({
    required String category,
  }) async {
    try {
      _isLoading = true;
      update();
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
      _isLoading = false;
      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
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
      Get.snackbar('', e.toString());
    }
  }

  Future<void> fetchAllProduct() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepository.fetchAllProduct();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productNew.add(
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
      Get.snackbar('', e.toString());
    }
  }

  @override
  void onInit() {
    fetchAllProduct();
    fetchRatingProduct();
    super.onInit();
  }
}
