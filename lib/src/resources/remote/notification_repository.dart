// import 'package:dio/dio.dart';

// import '../../models/notification_model.dart';
// import '../../public/api_gateway.dart';
// import '../base_repository.dart';

// class NotificationRepository {
//   Future<List<NotificationModel>> getNotifications() async {
//     Response response = await BaseRepository().getRoute(
//       ApiGateway.NOTIFICATION,
//     );
//     print(response.data.toString());
//     if (response.statusCode == 200) {
//       List<dynamic> resultJson = response.data['data'];
//       return resultJson.map((item) => NotificationModel.fromMap(item)).toList();
//     }

//     return [];
//   }
// }
