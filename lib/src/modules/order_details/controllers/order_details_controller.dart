import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/routes/app_pages.dart';

import '../repositories/order_details_repository.dart';
import '../../../services/socket/socket_emit.dart';

import '../../../models/order_model.dart';
import '../../../public/components.dart';
import '../../../public/constants.dart';

class OrderDetailsController extends GetxController {
  final OrderDetailsRepository orderDetailsRepository;
  OrderDetailsController(
    this.orderDetailsRepository
  );

  int currentStep = 0;

  void changeOrderStatus(String orderId) async {
    try {
        SocketEmit().changeOrderStatus(orderId);
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Change Order Status");
    }
  }
  
  void OrderStatus(dynamic data){
  currentStep = data['status'];
  update();
  }

  void deleteOrder({
    required OrderModel order,
  }) async {
    try {
      diox.Response response = await orderDetailsRepository.deleteOrder(order: order);

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
}
