
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
  ProductEditController({
    required this.editProductRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void deleteProduct({
    required ProductModel product,
  }) async {
    try {
      diox.Response response = await editProductRepository.deleteProduct(product: product);

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          AppNavigator.popUntil(AppRoutes.NAVIGATION);
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
