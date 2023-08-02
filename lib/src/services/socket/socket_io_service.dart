import 'package:shop_app/src/public/api_gateway.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../public/sockets.dart';

IO.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  socket = IO.io(
    ApiGateway.BASEURL,
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  socket!.connect();

  socket!.onConnect((_) {
    print('Connected');

    socket!.on(SocketEvent.USER_ONLINE, (data) {
      print('Received new product: $data');
      // Get.find<AdminController>().receivedNewProduct(data);
    });

    socket!.onDisconnect((_) => print('Disconnected'));
  });

  socket!.connect();
}

void disconnectBeforeConnect() {
  if (socket != null && socket!.connected) {
    socket!.disconnect();
  }
}
