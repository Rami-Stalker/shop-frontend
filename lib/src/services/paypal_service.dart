// import 'package:paypal_sdk/paypal_sdk.dart';
// import 'package:get/get.dart';

// class PayPalService {
//   Future<void> initiatePayment(double amount) async {
//     final description = 'Payment for your product/service'; // Change as needed

//     final payment = PayPalPayment(
//       amount: amount.toString(),
//       currency: 'USD', // Change as needed
//       description: description,
//       paymentType: PayPalPaymentType.paypal,
//     );

//     final result = await PayPalService.executePayment(payment);
//     if (result) {
//       // Payment successful
//       Get.snackbar('Success', 'Payment successful!');
//       // Add code to handle successful transaction (e.g., update database)
//     } else {
//       // Payment failed
//       Get.snackbar('Error', 'Payment failed.');
//     }
//   }

//   static Future<bool> executePayment(PayPalPayment payment) async {
//     try {
//       final result = await PayPalPayment.create(payment);
//       return result.status == PayPalPaymentStatus.success;
//     } catch (e) {
//       print('Error executing payment: $e');
//       return false;
//     }
//   }
// }