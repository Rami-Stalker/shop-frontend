import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/src/core/network/network_info.dart';
import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/modules/home/repositories/home_repository.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepository homeRepository;
  final NetworkInfo networkInfo;
  HomeController({
    required this.homeRepository,
    required this.networkInfo,
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

  Future<void> fetchRatingProduct() async {
    try {
      if (await networkInfo.isConnected) {
        _isLoading = true;
      update();
      http.Response res = await homeRepository.fetchRatingProduct();
      Constants.httpErrorHandle(
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
      } else {
        Components.showSnackBar('Make sure you are connected to the internet', title: 'You are offline');
      }

      
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<void> fetchNewestProduct() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepository.fetchNewestProduct();

      Constants.httpErrorHandle(
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
      Components.showSnackBar(e.toString());
    }
  }

  @override
  void onInit() {
    fetchNewestProduct();
    fetchRatingProduct();
    super.onInit();
  }
}
