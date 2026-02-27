import 'package:backend/src/server/chat/chat.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import '../../../auth/src/require_user.dart';
import '../../ws.dart';

class WsRouter {
  const WsRouter({
    required WebSocketBase ws,
    required IChatRealTimeRepository chatRealTimeRepository,
    required IMessageRealTimeRepository messageRealTimeRepository,
  }) : _ws = ws,
       _chatRepository = chatRealTimeRepository,
       _messageRepository = messageRealTimeRepository;

  final WebSocketBase _ws;
  final IChatRealTimeRepository _chatRepository;
  final IMessageRealTimeRepository _messageRepository;

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
          await message.mapOrNull(
            joinToChat: (payload, _) => _chatRepository.joinToChat(
              socket: socket,
              chatId: payload.chatId,
            ),
            leaveFromChat: (payload, _) => _chatRepository.leaveFromChat(
              socket: socket,
              chatId: payload.chatId,
            ),
            createdMessage: (payload, _) => _messageRepository.sendMessage(
              message: payload.message as PartialMessage,
              chatId: payload.message.chatId,
            ),
          );
        }, onError: (error) {});
      }, onDone: () => _ws.removeConnection(uid: uid, socket: socket));
    })(request);
  }
}
