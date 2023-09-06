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
      Components.showSnackBar(e.toString());
    }
  }
  
  void changeOrderStatusToUser(dynamic data){
  currentStep = data['status'];
  print('11111111111111111111111111111111111');
  print(currentStep);
  update();
  }

  void deleteOrder({
    required OrderModel order,
  }) async {
    try {
      diox.Response response = await orderDetailsRepository.deleteOrder(order: order);

      Constants.handleApi(
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
