import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';
import '../repositories/home_admin_repository.dart';

class AdminController extends GetxController implements GetxService {
  final AdminRepository adminRepository;
  AdminController({
    required this.adminRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController productNameC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController quantityC = TextEditingController();

  final TextEditingController productNameUC = TextEditingController();
  final TextEditingController descreptionUC = TextEditingController();
  final TextEditingController priceUC = TextEditingController();
  final TextEditingController quantityUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productNameC.dispose();
    descriptionC.dispose();
    priceC.dispose();
    quantityC.dispose();
    productNameUC.dispose();
    descreptionUC.dispose();
    priceUC.dispose();
    quantityUC.dispose();
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    List<ProductModel> products = [];
    try {
      diox.Response response = await adminRepository.fetchAllProducts();

    Constants.handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
            products =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
      },
    );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
    return products;
  }

  void deleteProduct({
    required ProductModel product,
    // required VoidCallback onSuccess,
  }) async {
    try {
      diox.Response response = await adminRepository.deleteProduct(product: product);

      Constants.handleApi(
        response: response,
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
      diox.Response response = await adminRepository.updateProduct(
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
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
