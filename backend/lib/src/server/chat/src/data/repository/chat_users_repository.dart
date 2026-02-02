import 'package:backend/src/core/ws/ws.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ChatType {
  join(value: 'chat_join'),
  leave(value: 'chat_leave'),
  created(value: 'chat_created'),
  deleted(value: 'chat_deleted'),
  updated(value: 'chat_updated'),
  error(value: 'chat_error');

  const ChatType({required this.value});
  final String value;

  factory ChatType.fromString(String type) {
    return values.firstWhere(
      (element) => element.value == type,
      orElse: () => throw FormatException('Unknown  response type: $type'),
    );
  }

  static bool isChatType(String type) =>
      values.any((element) => element.value == type);
}

abstract interface class IChatUsersRepository {
  Future<void> fromMessage(
    MessageEnvelope message, {
    required String uid,
    required WebSocketChannel socket,
  });

  Future<void> createChat({
    required String uid,
    required Map<String, Object?> chat,
  });

  Future<void> joinToChat({
    required WebSocketChannel socket,
    required int chatId,
  });

  Future<void> removeFromChat({
    required WebSocketChannel socket,
    required int chatId,
  });

  Future<void> broadcastToChat(MessageEnvelope message, {required int chatId});
}

class ChatUsersRepositoryImpl implements IChatUsersRepository {
  ChatUsersRepositoryImpl({required WebSocketBase ws}) : _ws = ws;

  final WebSocketBase _ws;

  final Map<int, Set<WebSocketChannel>> _chatOnlineUsers = {};

  @override
  Future<void> fromMessage(
    MessageEnvelope message, {
    required String uid,
    required WebSocketChannel socket,
  }) async {
    final type = message.type;
    if (ChatType.isChatType(type)) {
      switch (ChatType.fromString(type)) {
        case .created:
          await createChat(uid: uid, chat: message.payload);
        case .join:
          if (message.payload case <String, Object?>{'chat_id': int chatId}) {
            await joinToChat(socket: socket, chatId: chatId);
          } else {
            throw FormatException(
              'Invalid payload for join to chat: ${message.payload}',
            );
          }
        case .leave:
          if (message.payload case <String, Object?>{'chat_id': int chatId}) {
            await removeFromChat(socket: socket, chatId: chatId);
          } else {
            throw FormatException(
              'Invalid payload for leave chat: ${message.payload}',
            );
          }
        case .deleted:
        case .updated:
        case .error:
      }
    }
  }

  @override
  Future<void> createChat({
    required String uid,
    required Map<String, Object?> chat,
  }) async => _ws.sendToUser(ChatType.created.value, chat, uid: uid);

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
  Future<void> removeFromChat({
    required WebSocketChannel socket,
    required int chatId,
  }) async => _chatOnlineUsers[chatId]?.remove(socket);

  @override
  Future<void> broadcastToChat(
    MessageEnvelope message, {
    required int chatId,
  }) async {
    final sockets = _chatOnlineUsers[chatId];
    if (sockets == null) return;
    for (final socket in sockets) {
      _ws.send(socket, message.type, message.payload);
    }
  }
}
