import 'dart:async';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../repositories/order_repository.dart';

import '../../../models/order_model.dart';
import '../../../public/constants.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepository orderRepository;
  OrderController(
    this.orderRepository,
  );

  Future<List<OrderModel>> fetchAllOrders() async {
      List<OrderModel> orders = [];
      diox.Response response = await orderRepository.fetchAllOrders();
      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          List rawData = response.data;
            orders =
                rawData.map((e) => OrderModel.fromMap(e)).toList();
        },
      );
      return orders;
  }

  Future<List<OrderModel>> fetchUserOrders() async {
      List<OrderModel> userOrders = [];
      diox.Response response = await orderRepository.fetchUserOrder();
      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          List rawData = response.data;
            userOrders =
                rawData.map((e) => OrderModel.fromMap(e)).toList();
        },
      );
      return userOrders;
  }
}