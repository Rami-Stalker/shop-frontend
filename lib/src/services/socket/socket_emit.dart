import 'socket.dart';
import '../../public/sockets.dart';

class SocketEmit {
  changeOrderStatus(String orderId) {
    socket!.emit(
      SocketEvent.CHANGE_ORDER_STATUS,
      {'orderId': orderId},
    );
  }


  // sendDeviceInfo() async {
  //   DeviceModel deviceModel = await getDeviceDetails();
  //   socket!.emit(
  //     SocketEvent.SEND_FCM_TOKEN_CSS,
  //     deviceModel.toMap(),
  //   );
  // }
}
