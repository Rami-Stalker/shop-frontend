import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/core/utils/constants/error_handling.dart';

import '../../../models/order_model.dart';
import '../repositories/user_order_repository.dart';

class UserOrderController extends GetxController implements GetxService {
  final UserOrderRepository userOrderRepository;
  UserOrderController({
    required this.userOrderRepository,
  });

  

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<OrderModel>> fetchUserOrders() async {
      List<OrderModel> userOrders = [];
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
      return userOrders;
  }
}