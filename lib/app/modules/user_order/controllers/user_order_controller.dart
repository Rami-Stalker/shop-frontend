import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/modules/user_order/repositories/user_order_repository.dart';

import '../../../core/utils/components/components.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../models/order_model.dart';


class UserOrderController extends GetxController implements GetxService {
  final UserOrderRepository userOrderRepository;
  UserOrderController({
    required this.userOrderRepository,
  });

  List<OrderModel> myOrder = [];

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
            myOrder.add(
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
      Components.showCustomSnackBar(e.toString());
    }
  }

  @override
  void onInit() {
    fetchUserOrders();
    super.onInit();
  }
}
