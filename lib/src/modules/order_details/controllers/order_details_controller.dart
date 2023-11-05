import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/modules/navigator/views/navigation_view.dart';

import '../repositories.dart/order_details_repository.dart';
import '../../../services/socket/socket_emit.dart';

import '../../../models/order_model.dart';
import '../../../public/components.dart';
import '../../../public/constants.dart';

class OrderDetailsController extends GetxController {
  final OrderDetailsRepository orderDetailsRepository;
  OrderDetailsController({
    required this.orderDetailsRepository,
  });

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
          Get.to(Navigation(initialIndex: 2));
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
