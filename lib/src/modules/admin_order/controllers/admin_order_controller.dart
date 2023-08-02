import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../public/components.dart';
import '../../../models/order_model.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../repositories/admin_order_repository.dart';


class AdminOrderController extends GetxController {
  final AdminOrderRepository adminOrderRepository;
  AdminOrderController({
    required this.adminOrderRepository,
  });

  List<OrderModel> orders = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void fetchAllOrders() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await adminOrderRepository.fetchAllOrders();
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
      _isLoading = false;
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  int currentStep = 0;

  void changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    try {
      http.Response res =
          await adminOrderRepository.changeOrderStatus(status: status, order: order);

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          currentStep += 1;
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void deleteOrder({
    required OrderModel order,
  }) async {
    try {
      http.Response res = await adminOrderRepository.deleteOrder(order: order);

      Constants.httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.toNamed(Routes.ADMIN_NAVIGATOR);
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  @override
  void onInit() {
    fetchAllOrders();
    super.onInit();
  }
}
