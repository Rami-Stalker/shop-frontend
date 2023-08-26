import 'package:get/get.dart';
import '../../config/application.dart';
import '../../modules/order_details/controllers/order_details_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../public/sockets.dart';
import 'socket_emit.dart';

IO.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = Application.socketUrl;
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder().enableForceNew().setTransports(['websocket']).build(),
  );

  socket!.connect();
  socket!.onConnect((_) async {
    print('Connected');

    socket!.on(SocketEvent.CHANGE_ORDER_STATUS_TO_USER, (data) {
      print('Received new product: $data');
      Get.find<OrderDetailsController>().changeOrderStatusToUser(data);
    });

    SocketEmit().sendDeviceInfo();

    socket!.onDisconnect((_) => print('Disconnected'));
  });

  socket!.connect();
}

void disconnectBeforeConnect() {
  if (socket != null && socket!.connected) {
    socket!.disconnect();
  }
}
