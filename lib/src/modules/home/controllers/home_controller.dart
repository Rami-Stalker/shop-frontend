import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/local/user_local.dart';
import '../../../core/network/network_info.dart';
import '../../../public/components.dart';
import '../repositories/home_repository.dart';

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

  Map<String?, int> isFavorite = {};

  
  List<ProductModel> ProductsTopRest = [];
  List<ProductModel> ProductsMostPopular = [];
  List<ProductModel> ProductsMostRecent = [];

  Future<void> fetchProductsTopRest() async {
    try {
      if (await networkInfo.isConnected) {
        _isLoading = true;
        update();
        diox.Response response = await homeRepository.fetchProductsTopRest();
        AppConstants.handleApi(
          response: response,
          onSuccess: () {
            List rawData = response.data;
            ProductsTopRest =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
          },
        );
        _isLoading = false;
        update();
      } else {
        Components.showToast('You are offline');
      }
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "catch");
    }
  }

  Future<void> fetchProductsMostPopular() async {
    try {
        _isLoading = true;
        update();
        diox.Response response = await homeRepository.fetchProductsMostPopular();
        AppConstants.handleApi(
          response: response,
          onSuccess: () {
            List rawData = response.data;
            ProductsMostPopular =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
                print(ProductsMostPopular);
          },
        );
        _isLoading = false;
        update();
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "catch");
    }
  }

  Future<void> fetchProductsMostRecent() async {
    try {
        _isLoading = true;
        update();
        diox.Response response = await homeRepository.fetchProductsMostRecent();

        AppConstants.handleApi(
          response: response,
          onSuccess: () {
            List rawData = response.data;
            ProductsMostRecent =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
            for (var i = 0; i < ProductsMostRecent.length; i++) {
              if (UserLocal()
                  .getUser()!
                  .favorites!
                  .contains(ProductsMostRecent[i].id)) {
                isFavorite[ProductsMostRecent[i].id] = 1;
              } else {
                isFavorite[ProductsMostRecent[i].id] = 0;
              }
            }
          },
        );
        _isLoading = false;
        update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  setFavorite(String? id, int val) {
    isFavorite[id] = val;
    update();
  }

  void changeMealFavorite(String mealId) async {
    try {
      diox.Response response = await homeRepository.changeMealFavorite(mealId);

      AppConstants.handleApi(
        response: response,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Change Meal Favorite");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProductsTopRest();
    fetchProductsMostPopular();
    fetchProductsMostRecent();
  }
}
