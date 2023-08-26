import 'dart:convert';

import 'package:get/get.dart';
import '../core/api/api_client.dart';
import '../public/api_gateway.dart';
import '../public/components.dart';
import 'package:http/http.dart' as http;
import '../models/notification_model.dart';

import '../public/constants.dart';

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

      Constants.httpErrorHandle(res: res, onSuccess: () async {});
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<List<NotificationModel>> getNotofication() async {
    List<NotificationModel> notifications = [];
    http.Response res = await apiClient.getData(
      ApiGateway.GET_NOTIFICATIONS,
    );

    Constants.httpErrorHandle(
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

      Constants.httpErrorHandle(res: res, onSuccess: () async {});
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
