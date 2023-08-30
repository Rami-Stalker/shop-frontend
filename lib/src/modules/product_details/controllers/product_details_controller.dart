import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';
import '../repositories/product_detailes_repository.dart';
import '../../../themes/app_colors.dart';

import '../../../models/product_model.dart';

class ProductDetailsController extends GetxController implements GetxService {
  final ProductDetailsRepository productDetailsRepository;
  ProductDetailsController({
    required this.productDetailsRepository,
  });

  Rx<double> avgRating = Rx(0);
  Rx<double> myRating = Rx(0);

  // void rateProduct({
  //   required ProductModel product,
  //   required double rating,
  // }) async {S
  //   try {
  //     await productDetailsRepository.rateProduct(
  //         product: product, rating: rating);

  //     update();
  //   } catch (e) {
  //     Get.snackbar('', e.toString());
  //   }
  // }

  /////////////////////////

  late CartController _cart = CartController(
    cartRepository: Get.find(),
  );

  final Rx<int> _quantity = 0.obs;
  Rx<int> get quantity => _quantity;

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
