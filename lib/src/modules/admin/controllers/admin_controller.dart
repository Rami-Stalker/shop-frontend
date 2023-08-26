import 'dart:convert';

import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';
import '../repositories/admin_repository.dart';

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
      http.Response res = await adminRepository.fetchAllProducts();
      print('ddddddddddddddddddddddddddd');
      print(jsonDecode(res.body)[0]);
    Constants.httpErrorHandle(
      res: res,
      onSuccess: () {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          products.add(
            ProductModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
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
      http.Response res = await adminRepository.deleteProduct(product: product);

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
      http.Response res = await adminRepository.updateProduct(
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
