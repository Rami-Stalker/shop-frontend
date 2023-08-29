import 'dart:convert';

import 'package:dio/dio.dart' as diox;
import 'package:get/get.dart';
import 'package:shop_app/src/core/api/base_repository.dart';

import '../public/api_gateway.dart';
import '../public/components.dart';
import '../models/notification_model.dart';

import '../public/constants.dart';

class NotificationController extends GetxController implements GetxService {
  final BaseRepository baseRepository;

  NotificationController({
    required this.baseRepository,
  });

  void pushNotofication({
    required String userId,
    required String title,
    required String message,
  }) async {
    try {
      var body = {
        "userId": userId,
        "title": title,
        "message": message,
      };
      diox.Response response = await baseRepository.postRoute(
        ApiGateway.SEND_NOTIFICATION,
        body,
      );

      Constants.handleApi(
        response: response,
        onSuccess: () async {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<List<NotificationModel>> getNotofication() async {
    List<NotificationModel> notifications = [];
    diox.Response response = await baseRepository.getRoute(
      ApiGateway.GET_NOTIFICATIONS,
    );

    Constants.handleApi(
        response: response,
        onSuccess: () async {
          for (var i = 0; i < jsonDecode(response.data).length; i++) {
            notifications.add(
              NotificationModel.fromJson(
                jsonEncode(
                  jsonDecode(
                    response.data,
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
      diox.Response response = await baseRepository.postRoute(
        ApiGateway.SEEN_NOTIFICATION,
        {},
      );

      Constants.handleApi(
        response: response,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
