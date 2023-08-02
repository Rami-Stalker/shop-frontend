import 'dart:convert';

import 'package:get/get.dart';
import 'package:shop_app/src/core/api/api_client.dart';
import 'package:shop_app/src/public/api_gateway.dart';
import 'package:shop_app/src/core/utils/components/app_components.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/src/core/utils/constants/error_handling.dart';
import 'package:shop_app/src/models/notification_model.dart';

class NotificationController extends GetxController implements GetxService {
  final ApiClient apiClient;

  NotificationController({
    required this.apiClient,
  });

  void pushNotofication({
    required String userId,
    required String title,
    required String body,
  }) async {
    try {
      http.Response res = await apiClient.postData(
        ApiGateway.SEND_NOTIFICATION,
        jsonEncode(
          {
            "userId": userId,
            "title": title,
            "body": body,
          },
        ),
      );

      httpErrorHandle(res: res, onSuccess: () async {});
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }

  Future<List<NotificationModel>> getNotofication() async {
    List<NotificationModel> notifications = [];
    http.Response res = await apiClient.getData(
      ApiGateway.GET_NOTIFICATIONS,
    );

    httpErrorHandle(
        res: res,
        onSuccess: () async {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            notifications.add(
              NotificationModel.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  )[i],
                ),
              ),
            );
          }
        });
    return notifications;
  }

  void seenNotofication() async {
    try {
      http.Response res = await apiClient.postData(
        ApiGateway.SEEN_NOTIFICATION,
        jsonEncode({}),
      );

      httpErrorHandle(res: res, onSuccess: () async {});
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }
}
