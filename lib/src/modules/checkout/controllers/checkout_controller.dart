import 'package:shop_app/src/core/utils/app_colors.dart';
import 'package:shop_app/src/core/utils/components/app_components.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shop_app/src/modules/cart/repositories/cart_repository.dart';
import 'package:shop_app/src/modules/checkout/repositories/checkout_repository.dart';

import '../../../core/utils/constants/error_handling.dart';
import '../../navigator/controllers/navigator_user_controller.dart';

class CheckoutController extends GetxController implements GetxService {
  final CheckoutRepository orderRepository;
  CheckoutController({
    required this.orderRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<void> makePayment() async {
  //   final transactionResult = await PayPalManager.makePayment('USD', 100.0);

  //   if (transactionResult.status == PayPalStatus.success) {
  //     // Payment successful, handle success scenario
  //     print('Payment successful! Transaction ID: ${transactionResult.transactionId}');
  //   } else if (transactionResult.status == PayPalStatus.cancelled) {
  //     // Payment cancelled by user, handle cancellation scenario
  //     print('Payment cancelled by user.');
  //   } else {
  //     // Payment failed, handle failure scenario
  //     print('Payment failed. Error message: ${transactionResult.errorMessage}');
  //   }
  // }

  void checkout({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    try {
      http.Response res = await orderRepository.checkout(
        productsId: productsId,
        userQuants: userQuants,
        totalPrice: totalPrice,
        address: address,
      );
      httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.find<CartRepository>().removeCart();
          AppComponents.showCustomSnackBar(
            'add Order Successed',
            title: 'Order',
            color: AppColors.mainColor,
          );
          Get.find<NavigatorUserController>().currentIndex.value = 0;
        },
      );
      update();
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }
}
