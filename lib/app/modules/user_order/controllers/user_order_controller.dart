import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/modules/user_order/repositories/user_order_repository.dart';

import '../../../core/utils/components/app_components.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../models/order_model.dart';


class UserOrderController extends GetxController implements GetxService {
  final UserOrderRepository userOrderRepository;
  UserOrderController({
    required this.userOrderRepository,
  });

  List<OrderModel> userOrders = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void fetchUserOrders() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await userOrderRepository.fetchMyOrder();
      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            userOrders.add(
              OrderModel.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  )[i],
                ),
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }

  @override
  void onInit() {
    fetchUserOrders();
    super.onInit();
  }
}
