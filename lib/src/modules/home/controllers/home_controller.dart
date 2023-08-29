
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import '../../../core/network/network_info.dart';
import '../../../public/components.dart';
import '../repositories/home_repository.dart';

import '../../../models/product_model.dart';
import '../../../public/constants.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepository homeRepository;
  final NetworkInfo networkInfo;
  HomeController({
    required this.homeRepository,
    required this.networkInfo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel> productNewest = [];
  List<ProductModel> productRating = [];

  Future<void> fetchRatingProduct() async {
    try {
      if (await networkInfo.isConnected) {
        _isLoading = true;
        update();
        diox.Response response = await homeRepository.fetchRatingProduct();
        Constants.handleApi(
          response: response,
          onSuccess: () {
            List rawData = response.data;
            productRating =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
          },
        );
        _isLoading = false;
        update();
      } else {
        Components.showToast('You are offline');
      }
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "catch");
    }
  }

  Future<void> fetchNewestProduct() async {
    try {
      if (await networkInfo.isConnected) {
        _isLoading = true;
        update();
        diox.Response response = await homeRepository.fetchNewestProduct();

        Constants.handleApi(
          response: response,
          onSuccess: () {
            List rawData = response.data;
            productNewest =
                rawData.map((e) => ProductModel.fromMap(e)).toList();
            // for (var i = 0; i < jsonDecode(response.data).length; i++) {
            //   productNewest.add(
            //     ProductModel.fromJson(
            //       jsonEncode(
            //         jsonDecode(
            //           response.data,
            //         )[i],
            //       ),
            //     ),
            //   );
            // }
          },
        );
        _isLoading = false;
        update();
      } else {
        Components.showToast('You are offline');
      }
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRatingProduct();
    fetchNewestProduct();
  }
}
