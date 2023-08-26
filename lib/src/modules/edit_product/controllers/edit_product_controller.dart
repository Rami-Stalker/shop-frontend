import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';
import '../repositories/edit_product_repository.dart';

class EditProductController extends GetxController implements GetxService {
  final EditProductRepository editProductRepository;
  EditProductController({
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
      http.Response res = await editProductRepository.deleteProduct(product: product);

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {},
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
      http.Response res = await editProductRepository.updateProduct(
        id: id,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
      );

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          Components.showSnackBar(
            'Update Seccessfully',
            title: 'Update',
            color: colorPrimary,
          );
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
