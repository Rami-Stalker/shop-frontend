import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PaypalService extends StatelessWidget {
  final int total;
  final List<Map<String, dynamic>> items;
  final Function(Map) onSuccess;

  const PaypalService({
    required this.total,
    required this.items,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return PaypalCheckout(
                sandboxMode: true,
                clientId: "AcQm7QNZv-ZiYOz8numQnKq6bIrPo7BKOoCm2Pl8QqyiQOj23AhrqLX7fPJhWzCrICRXI1I6av_qjXvB",
                secretKey: "EDudkdQl00Xw87FqYZoHCWXUa63Pr-_aTnTQl9Df-KlIlqdFYTRR43oQWJPgwcQ3FW9wejly1RXZuezB",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: [
                  {
                    "amount": {
                      "total": total.toString(),
                      "currency": "USD",
                      "details": {
                        "subtotal": total,
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "USD"
                        }
                      ],
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: onSuccess,
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              );
  }
}
