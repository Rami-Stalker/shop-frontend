import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../core/picker/picker.dart';
import '../../../routes/app_pages.dart';
import '../repositories/product_add_repository.dart';
import '../../../public/components.dart';

import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';

class ProductAddController extends GetxController implements GetxService {
  final ProductAddRepository addProductRepository;
  ProductAddController(this.addProductRepository);

  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController quantityController;
  late TextEditingController timeController;

  @override
  void onInit() {
    productNameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    discountController = TextEditingController();
    quantityController = TextEditingController();
    timeController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    discountController.dispose();
    quantityController.dispose();
    timeController.dispose();
    super.dispose();
  }

  String category = 'Drinks';

  final List<String> productCategories = [
    'Drinks',
    'Breakfast',
    'Wraps',
    'Brunch',
    'Burgers',
    'FrenchToast',
    'Sides',
    'ToastedPaninis'
  ];

  void changeCategory(String? newVal) {
    category = newVal!;
    update();
  }

  RxList<File> imageFileSelected = <File>[].obs;

  void selectImage() async {
    List<File>? images = await pickImagesFromGallery();
    if (images.isNotEmpty) {
      for (var element in images) {
        imageFileSelected.add(element);
      }
    }
    update();
  }

  void addFile(File file) {
    imageFileSelected.add(file);
  }

  void removePhoto(int index) {
    imageFileSelected.removeAt(index);
    update();
  }

  void addProduct({
    required String name,
    required String description,
    required int price,
    required int discount,
    required int quantity,
    required String category,
    required List<File> images,
    required String time,
  }) async {
    try {
      List<String> imagesUrl = [];

      if (images.isNotEmpty) {
        for (var i = 0; i < imageFileSelected().length; i++) {
          imagesUrl.add(
              await Components.cloudinaryPublic(imageFileSelected()[i].path));
        }
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imagesUrl,
        category: category,
        price: price,
        discount: discount,
        time: time,
      );

      diox.Response response = await addProductRepository.addProduct(
        product: product,
      );

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          Components.showSnackBar(
            "Product Added Successfully!",
            title: "Product",
            color: colorPrimary,
          );
          clearController();
          AppNavigator.replaceWith(AppRoutes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void clearController() {
    productNameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    discountController.text = '';
    quantityController.text = '';
    timeController.text = '';
  }
}
