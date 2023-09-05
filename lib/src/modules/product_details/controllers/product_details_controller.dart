import 'package:dio/dio.dart' as diox;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:shop_app/src/public/components.dart';
import 'package:shop_app/src/public/constants.dart';
import '../../../models/rating_model.dart';
import '../../../resources/local/user_local.dart';
import '../../cart/controllers/cart_controller.dart';
import '../repositories/product_detailes_repository.dart';
import '../../../themes/app_colors.dart';

import '../../../models/product_model.dart';

class ProductDetailsController extends GetxController implements GetxService {
  final ProductDetailsRepository productDetailsRepository;
  ProductDetailsController({
    required this.productDetailsRepository,
  });

  final _getStorage = GetStorage();
  final myRatingKey = 'myRating';

  List<RatingModel> ratings = [];
  Rx<double> avgRating = 0.0.obs;

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

  
  // Rx<double> myRating = 0.0.obs;
  


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

      Constants.handleApi(
        response: response,
        onSuccess: () {},
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Rate Product");
    }
  }

  /////////////////////////

  late CartController _cart = CartController(
    cartRepository: Get.find(),
  );

  

  void setQuantity(bool isIncrement, int productQuantity) {
    if (isIncrement) {
      _quantity.value = checkQuantity(_quantity.value + 1, productQuantity);
    } else {
      _quantity.value = checkQuantity(_quantity.value - 1, productQuantity);
    }
  }

  int checkQuantity(int quantity, int productQuantity) {
    if (quantity < 0) {
      Get.snackbar(
        'Item count',
        "You can't reduce more !",
        backgroundColor: colorPrimary,
        colorText: mCL,
      );
      return 0;
    } else if (quantity > productQuantity) {
      Get.snackbar(
        'Item count',
        "You ordered more than the available quantity !",
        backgroundColor: colorPrimary,
        colorText: mCL,
      );
      return productQuantity;
    } else {
      return quantity;
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product.id, product, quantity.value);
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
}
