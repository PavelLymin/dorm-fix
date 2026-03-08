import 'package:logger/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import '../../../../server/chat/chat.dart';
import '../../../auth/src/require_user.dart';
import '../../ws.dart';

class WsRouter {
  const WsRouter({
    required Logger logger,
    required WebSocketBase ws,
    required IChatRealTimeRepository chatRealTimeRepository,
    required IMessageRealTimeRepository messageRealTimeRepository,
  }) : _logger = logger,
       _ws = ws,
       _chatRepository = chatRealTimeRepository,
       _messageRepository = messageRealTimeRepository;

  final Logger _logger;
  final WebSocketBase _ws;
  final IChatRealTimeRepository _chatRepository;
  final IMessageRealTimeRepository _messageRepository;

  Handler get handler {
    final router = Router();

    router.get('/connection', _connect);
    return router.call;
  }

  void _sendPresence(String uid, bool isOnline) => _ws.sendBroadcast(
    envelope: MessageEnvelope(
      type: .presence,
      payload: .presence(uid: uid, isOnline: isOnline),
    ),
  );

  Future<Response> _connect(Request request) async {
    final uid = RequireUser.getUserId(request);
    _sendPresence(uid, true);

    return webSocketHandler((socket, _) {
      _ws.addConnection(uid: uid, socket: socket);
      socket.stream.listen(
        (data) async {
          try {
            final message = await _ws.decodeRaw(data);
            _logger.i(message);
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
              typing: (payload, _) => _chatRepository.broadcastToChat(
                envelope: MessageEnvelope(type: .typing, payload: payload),
                chatId: payload.chatId,
                skipSocket: socket,
              ),
            );
          } on Object catch (e) {
            _ws.send(
              socket: socket,
              envelope: MessageEnvelope(
                type: .error,
                payload: .error(message: e.toString()),
              ),
            );
          }
        },
        onDone: () {
          _ws.removeConnection(uid: uid, socket: socket);
          _sendPresence(uid, false);
        },
      );
    })(request);
  }
}
