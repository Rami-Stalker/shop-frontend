import '../../../public/components.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../public/constants.dart';

import '../../../models/product_model.dart';
import '../repositories/home_admin_repository.dart';

class HomeAdminController extends GetxController implements GetxService {
  final HomeAdminRepository adminRepository;
  HomeAdminController(
    this.adminRepository,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<ProductModel>> fetchAllProducts() async {
    List<ProductModel> products = [];
    try {
      diox.Response response = await adminRepository.fetchAllProducts();

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          List rawData = response.data;
          products = rawData.map((e) => ProductModel.fromMap(e)).toList();
        },
      );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
    return products;
  }
}
