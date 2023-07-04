import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/app/modules/product_details/repositories/product_detailes_controller.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../models/product_model.dart';

class ProductDetailsController extends GetxController implements GetxService {
  final ProductDetailsRepository productDetailsRepository;
  ProductDetailsController({
    required this.productDetailsRepository,
  });

  Rx<double> avgRating = Rx(0);
  Rx<double> myRating = Rx(0);

  void addToCart({
    required ProductModel product,
    required int ord,
  }) async {
    try {
      await productDetailsRepository.addToCart(
        product: product,
        ord: ord,
      );
      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  void rateProduct({
    required ProductModel product,
    required double rating,
  }) async {
    try {
      await productDetailsRepository.rateProduct(
          product: product, rating: rating);

      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

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
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > productQuantity) {
      Get.snackbar(
        'Item count',
        "You ordered more than the available quantity !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
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
