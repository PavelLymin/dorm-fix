import 'package:backend/src/core/ws/ws.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract interface class IChatRealTimeRepository {
  Future<void> joinToChat({
    required WebSocketChannel socket,
    required int chatId,
  });

  Future<void> leaveFromChat({
    required WebSocketChannel socket,
    required int chatId,
  });

  Future<void> broadcastToChat({
    required MessageEnvelope envelope,
    required int chatId,
  });
}

class ChatRealTimeRepositoryImpl implements IChatRealTimeRepository {
  ChatRealTimeRepositoryImpl({required WebSocketBase ws}) : _ws = ws;

  final WebSocketBase _ws;

  final Map<int, Set<WebSocketChannel>> _chatOnlineUsers = {};

  @override
  Future<void> joinToChat({
    required WebSocketChannel socket,
    required int chatId,
  }) async {
    final users = _chatOnlineUsers.putIfAbsent(chatId, () => {});
    if (!users.contains(socket)) {
      users.add(socket);
    }
  }

  @override
  Future<void> leaveFromChat({
    required WebSocketChannel socket,
    required int chatId,
  }) async => _chatOnlineUsers[chatId]?.remove(socket);

  @override
  Future<void> broadcastToChat({
    required MessageEnvelope envelope,
    required int chatId,
  }) async {
    final sockets = _chatOnlineUsers[chatId];
    if (sockets == null) return;
    for (final socket in sockets) {
      _ws.send(socket: socket, envelope: envelope);
    }
  }
}
