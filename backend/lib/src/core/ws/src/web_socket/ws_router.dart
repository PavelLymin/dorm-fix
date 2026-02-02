import 'package:backend/src/server/chat/chat.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import '../../../auth/src/require_user.dart';
import '../../ws.dart';

class WsRouter {
  const WsRouter({
    required WebSocketBase ws,
    required IChatUsersRepository chatUsersRepository,
  }) : _ws = ws,
       _chatUsersRepository = chatUsersRepository;

  final WebSocketBase _ws;
  final IChatUsersRepository _chatUsersRepository;
  Handler get handler {
    final router = Router();

    router.get('/connection', _connect);
    return router.call;
  }

  Future<Response> _connect(Request request) async {
    final uid = RequireUser.getUserId(request);

    return webSocketHandler((socket, _) {
      _ws.addConnection(uid: uid, socket: socket);

      socket.stream.listen((data) async {
        await _ws.decodeRaw(data).then((message) async {
          await _chatUsersRepository.fromMessage(
            message,
            uid: uid,
            socket: socket,
          );
        }, onError: (error) {});
      }, onDone: () => _ws.removeConnection(uid: uid, socket: socket));
    })(request);
  }
}
