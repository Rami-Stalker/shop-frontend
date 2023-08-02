import 'dart:convert';
import 'dart:io';

import 'package:shop_app/src/public/components.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/src/modules/navigator/controllers/navigator_admin_controller.dart';
import 'package:shop_app/src/public/constants.dart';

import '../../../models/admin_model.dart';
import '../../../models/order_model.dart';
import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';
import '../repositories/admin_repository.dart';

class AdminController extends GetxController implements GetxService {
  final AdminRepository adminRepository;
  AdminController({
    required this.adminRepository,
  });

  List<ProductModel> products = [];
  List<OrderModel> orders = [];
  List<ProductModel>? productCategory = [];

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

  void addProduct({
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      List<String> imageUrl = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrl.add(res.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price,
        oldPrice: 0,
      );

      // SocketEmit().addProduct(product);

      http.Response res = await adminRepository.addProduct(
        product: product,
      );

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          Components.showSnackBar(
            "Product Added Successfully!",
            title: "Product",
            color: colorPrimary,
          );
          Get.back();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    

    http.Response res = await adminRepository.fetchAllProducts();

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
    return products;
  }

  void fetchCategoryProduct({
    required String category,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res =
          await adminRepository.fetchCategoryProduct(category: category);

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productCategory!.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
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

  int currentStep = 0;

  void changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    try {
      http.Response res =
          await adminRepository.changeOrderStatus(status: status, order: order);

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          currentStep += 1;
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void deleteOrder({
    required OrderModel order,
  }) async {
    try {
      http.Response res = await adminRepository.deleteOrder(order: order);

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.find<NavigatorAdminController>().currentIndex.value = 0;
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchEarnings() async {
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await adminRepository.fetchEarnings();

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}