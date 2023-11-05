import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../routes/app_pages.dart';
import '../repositories/product_add_repository.dart';
import '../../../public/components.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../../../themes/app_colors.dart';

class ProductAddController extends GetxController implements GetxService {
  final ProductAddRepository addProductRepository;
  ProductAddController({
    required this.addProductRepository,
  });

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
          AppNavigator.popUntil(AppRoutes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
