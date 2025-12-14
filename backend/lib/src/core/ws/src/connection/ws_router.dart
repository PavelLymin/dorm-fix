import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import '../../../auth/src/require_user.dart';
import '../../ws.dart';

class WsRouter {
  const WsRouter({required WsConnection connection}) : _connection = connection;

  final WsConnection _connection;

  Handler get handler {
    final router = Router();

    router.get('/connection', _connect);
    return router.call;
  }

  Future<Response> _connect(Request request) async {
    final uid = RequireUser.getUserId(request);

    return webSocketHandler((socket, _) {
      _connection.addConnection(uid: uid, socket: socket);

      socket.stream.listen((data) {
        _connection.sendToUser(uid: uid, message: data);
      }, onDone: () => _connection.removeConnection(uid: uid, socket: socket));
    })(request);
  }
}
