import 'package:dio/dio.dart' as diox;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/src/modules/home/repositories/home_repository.dart';

import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/public/constants.dart';
import '../../../controller/app_controller.dart';
import '../../../models/rating_model.dart';
import '../../../resources/local/user_local.dart';
import '../../cart/controllers/cart_controller.dart';
import '../repositories/product_detailes_repository.dart';

import '../../../models/product_model.dart';

class ProductDetailsController extends GetxController implements GetxService {
  final ProductDetailsRepository productDetailsRepository;
  ProductDetailsController(this.productDetailsRepository);

  final _getStorage = GetStorage();
  final myRatingKey = 'myRating';

  List<RatingModel> ratings = [];
  Rx<double> avgRating = 0.0.obs;

  RxBool isFavorite = false.obs;

  void saveMyRating(double myRating) async {
    _getStorage.write(myRatingKey, myRating);

    for (int i = 0; i < ratings.length; i++) {
      if (ratings[i].userId == UserLocal().getUserId()) {
        ratings[i].rating = myRating;
      }
    }
    update();
  }

  double getMyRating() {
    return _getStorage.read(myRatingKey) ?? 0;
  }

  void clearMyRating() {
    _getStorage.remove(myRatingKey);
  }

  final Rx<int> _quantity = 0.obs;
  Rx<int> get quantity => _quantity;

  void rateProduct({
    required String productId,
    required double rating,
  }) async {
    try {
      diox.Response response = await productDetailsRepository.rateProduct(
        productId: productId,
        rating: rating,
      );

      AppConstants.handleApi(
        response: response,
        onSuccess: () {},
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Rate Product");
    }
  }

  CartController _cart = AppGet.CartGet;

  void setQuantity(bool isIncrement, int productQuantity) {
    if (isIncrement) {
      _quantity.value = checkQuantity(_quantity.value + 1, productQuantity);
    } else {
      _quantity.value = checkQuantity(_quantity.value - 1, productQuantity);
    }
  }

  int checkQuantity(int quantity, int productQuantity) {
    if (quantity < 0) {
      Components.showSnackBar(
        title: "Item count",
        "You can't reduce more !",
      );
      return 0;
    } else if (quantity > productQuantity) {
      Components.showSnackBar(
        title: "Item count",
        "You ordered more than the available quantity !",
      );
      return productQuantity;
    } else {
      return quantity;
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, quantity.value);
    _quantity.value = _cart.getQuantity(product);
    update();
  }

  initProduct(ProductModel product, CartController cartController) {
    _cart = cartController;
    _quantity.value = _cart.getQuantity(product);
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  setFavorite() {
    isFavorite.value = !isFavorite.value;
    update();
  }

  void changeMealFavorite(String mealId) async {
    try {
      diox.Response response =
          await Get.find<HomeRepository>().changeMealFavorite(mealId);

      AppConstants.handleApi(
        response: response,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Change Meal Favorite");
    }
  }
}
