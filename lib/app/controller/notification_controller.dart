import 'dart:convert';

import 'package:get/get.dart';
import 'package:shop_app/app/core/api/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/core/utils/components/app_components.dart';

class NotificationController extends GetxController implements GetxService {
  final ApiClient apiClient;

  NotificationController({
    required this.apiClient,
  });

  void sendPushMessage({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAtEreg6g:APA91bEulzSGCR8gTQPCRX6NeDCcjkGmNd9EOgQKKZmoT8Rz6us4t-O_EWrMefitD1EKExVaeV-0FBG5GGWeusJmceOf_mxCDdoilAUeRVw7FeGBldgJUT8HJgVS2sKyYzJCTmmcsGvr',
        },
        body: jsonEncode(
          <String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "dbfood",
          },
          "to": token,
        }),
      );
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }
}
