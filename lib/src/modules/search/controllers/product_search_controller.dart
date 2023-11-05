import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../repositories/product_search_repository.dart';

import '../../../public/components.dart';
import '../../../models/product_model.dart';
import '../../../public/constants.dart';

class ProductSearchController extends GetxController implements GetxService {
  final ProductSearchRepository searchRepository;
  ProductSearchController({
    required this.searchRepository,
  });

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxString searchQuery = ''.obs;
  RxList<String> selectedCategories = <String>[].obs;
  Rx<RangeValues> priceRange = const RangeValues(20, 400).obs;

Future<void> fetchSearchProducts({String? query}) async {
  try {
    diox.Response response = await searchRepository.fetchSearchProduct(searchQuery: query!);

    AppConstants.handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        products.value = rawData.map((e) => ProductModel.fromMap(e)).toList();
      }
    );
    update();
  } catch (e) {
    Components.showSnackBar(e.toString());
  }
}

  List<ProductModel> filterProductsByPriceAndCategory({
    required RangeValues priceRange,
  }) {
    return products.where((product) {
      double productPrice = product.price.toDouble();
      bool priceFilter =
          productPrice >= priceRange.start && productPrice <= priceRange.end;
      bool categoryFilter =
          selectedCategories.isEmpty || selectedCategories.contains(product.category);
      bool searchFilter = searchQuery.isEmpty ||
          product.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      return priceFilter && categoryFilter && searchFilter;
    }).toList();
  }


  void changeSearchStatus(String value) {
  searchQuery.value = value;
  
  if (value != '') {
    
      fetchSearchProducts(query: value);
    } else {
      products.value = [];
    }
}

  void updatePriceRange(RangeValues range) {
    priceRange.value = range;
  }

}
