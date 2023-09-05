import 'package:shop_app/src/routes/app_pages.dart';

import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';
import '../repositories/product_edit_repository.dart';

class ProductEditController extends GetxController implements GetxService {
  final ProductEditRepository editProductRepository;
  ProductEditController({
    required this.editProductRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController productNameUC = TextEditingController();
  final TextEditingController descreptionUC = TextEditingController();
  final TextEditingController priceUC = TextEditingController();
  final TextEditingController quantityUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productNameUC.dispose();
    descreptionUC.dispose();
    priceUC.dispose();
    quantityUC.dispose();
  }

  void deleteProduct({
    required ProductModel product,
    // required VoidCallback onSuccess,
  }) async {
    try {
      diox.Response response = await editProductRepository.deleteProduct(product: product);

      Constants.handleApi(
        response: response,
        onSuccess: () {
          AppNavigator.replaceWith(Routes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void updateProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
  }) async {
    try {
      diox.Response response = await editProductRepository.updateProduct(
        id: id,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
      );

      Constants.handleApi(
        response: response,
        onSuccess: () {
          Components.showSnackBar(
            'Update Seccessfully',
            title: 'Update',
            color: colorPrimary,
          );
          AppNavigator.replaceWith(Routes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
