import 'package:shop_app/src/controller/app_controller.dart';
import '../../config/application.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../public/sockets.dart';
import '../../resources/local/user_local.dart';
import 'socket_emit.dart';

IO.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = Application.socketUrl;
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder()
        .enableForceNew()
        .setTransports(['websocket']).setExtraHeaders({
      'authorization': UserLocal().getAccessToken(),
    }).build(),
  );

  socket!.connect();
  socket!.onConnect((_) async {
    print('Connected');

    socket!.on(SocketEvent.CHANGE_ORDER_STATUS_TO_USER, (data) {
      print('Received new product: $data');
      AppGet.orderDetailsGet.changeOrderStatusToUser(data);
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
