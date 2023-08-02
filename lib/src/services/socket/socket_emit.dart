import 'package:shop_app/src/services/socket/socket_io_service.dart';
import '../../public/sockets.dart';

class SocketEmit {
  // addProduct(ProductModel product) {
  //   socket!.emit(SocketEvent.ADD_PRODUCT, product);
  // }

  answerQuestion(
      {required String answer,
      required String roomId,
      required String questionId}) {
    socket!.emit(SocketEvent.ANSWER_THE_QUESTION_CSS, {
      'idRoom': roomId,
      'idQuestion': questionId,
      'answer': answer,
    });
  }
}
