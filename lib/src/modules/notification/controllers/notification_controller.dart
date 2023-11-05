import 'package:dio/dio.dart' as diox;
import 'package:get/get.dart';

import '../../../models/notification_model.dart';
import '../../../public/components.dart';
import '../../../public/constants.dart';
import '../repositories/notification_repository.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepository notificationRepository;

  NotificationController({required this.notificationRepository});

  void pushNotofication({
    required String userId,
    required String title,
    required String message,
  }) async {
    try {
      diox.Response response = await notificationRepository.pushNotofication(
        userId: userId,
        title: title,
        message: message,
      );

      AppConstants.handleApi(
        response: response,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  Future<List<NotificationModel>> getNotofications() async {
    List<NotificationModel> notifications = [];
    diox.Response response = await notificationRepository.getNotofications();

    AppConstants.handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        notifications =
            rawData.map((e) => NotificationModel.fromMap(e)).toList();
      },
    );
    return notifications;
  }

  void seenNotofication() async {
    try {
      diox.Response response = await notificationRepository.seenNotofication();

      AppConstants.handleApi(
        response: response,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
