import '../../helpers/device_helper.dart';
import '../../models/device_model.dart';
import 'socket.dart';
import '../../public/sockets.dart';

class SocketEmit {
  changeOrderStatus(String OrderId) {
    socket!.emit(SocketEvent.CHANGE_ORDER_STATUS, {'OrderId': OrderId});
  }

  sendDeviceInfo() async {
    DeviceModel deviceModel = await getDeviceDetails();
    socket!.emit(
      SocketEvent.SEND_FCM_TOKEN_CSS,
      deviceModel.toMap(),
    );
  }
}
