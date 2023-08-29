import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../routes/app_pages.dart';
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

  RxInt currentStep = 0.obs;

  void changeOrderStatus(String OrderId) async {
    try {
        SocketEmit().changeOrderStatus(OrderId);
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
  
  void changeOrderStatusToUser(dynamic data){
  currentStep.value == data.status;
  }

  // void changeOrderStatus({
  //   required int status,
  //   required OrderModel order,
  // }) async {
  //   try {
  //     diox.Response res =
  //         await orderDetailsRepository.changeOrderStatus(status: status, order: order);

  //     Constants.httpErrorHandle(
  //       res: res,
  //       onSuccess: () {
  //         currentStep += 1;
  //       },
  //     );
  //     update();
  //   } catch (e) {
  //     Components.showSnackBar(e.toString());
  //   }
  // }

  void deleteOrder({
    required OrderModel order,
  }) async {
    try {
      diox.Response response = await orderDetailsRepository.deleteOrder(order: order);

      Constants.handleApi(
        response: response,
        onSuccess: () {
          Get.toNamed(Routes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
