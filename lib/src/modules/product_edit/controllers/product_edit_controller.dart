import 'package:flutter/material.dart';

import '../../../public/components.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../repositories/product_edit_repository.dart';

class ProductEditController extends GetxController implements GetxService {
  final ProductEditRepository editProductRepository;
  ProductEditController(this.editProductRepository);

  late TextEditingController productNameController;
  late TextEditingController descreptionController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController quantityController;
  late TextEditingController timeController;

  double currPageValue = 0;
  PageController pageController = PageController();
  final double height = 340;
  final double scaleFactor = 0.8;

  ProductModel product = Get.arguments['product'];

  @override
  void onInit() {
    productNameController = TextEditingController(text: product.name);
    descreptionController = TextEditingController(text: product.description);
    priceController = TextEditingController(text: product.price.toString());
    discountController = TextEditingController(text: product.discount.toString());
    quantityController = TextEditingController(text: product.quantity.toString());
    timeController = TextEditingController(text: product.time.toString());

    pageController.addListener(() {
        currPageValue = pageController.page!;
        update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descreptionController.dispose();
    priceController.dispose();
    discountController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void deleteProduct({
    required ProductModel product,
  }) async {
    try {
      diox.Response response =
          await editProductRepository.deleteProduct(product: product);

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          AppNavigator.replaceWith(AppRoutes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void productEdit({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
  }) async {
    try {
      diox.Response response = await editProductRepository.productEdit(
        id: id,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
      );

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          Components.showSnackBar(
            'Seccessfull',
            title: 'Product Edited',
            color: colorPrimary,
          );
          AppNavigator.replaceWith(AppRoutes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
