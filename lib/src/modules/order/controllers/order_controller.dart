import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../repositories/order_repository.dart';

import '../../../models/order_model.dart';
import '../../../public/constants.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepository orderRepository;
  OrderController({
    required this.orderRepository,
  });

  Future<List<OrderModel>> fetchAllOrders() async {
      List<OrderModel> orders = [];
      http.Response res = await orderRepository.fetchAllOrders();
      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            orders.add(
              OrderModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      return orders;
  }

  Future<List<OrderModel>> fetchUserOrders() async {
      List<OrderModel> userOrders = [];
      http.Response res = await orderRepository.fetchUserOrder();
      Constants.httpErrorHandle(
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