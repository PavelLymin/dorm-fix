import '../../../../../core/ws/ws.dart';

abstract interface class IChatRealTimeRepository {
  Future<void> joinToChat({required int chatId});

  Future<void> leaveFromChat({required int chatId});
}

class ChatRealTimeRepositoryImpl implements IChatRealTimeRepository {
  const ChatRealTimeRepositoryImpl({required IWebSocket webSocket})
    : _webSocket = webSocket;

  final IWebSocket _webSocket;

  @override
  Future<void> joinToChat({required int chatId}) async => _webSocket.send(
    envelope: MessageEnvelope(
      type: .chatJoin,
      payload: .joinToChat(chatId: chatId),
    ),
  );

  @override
  Future<void> leaveFromChat({required int chatId}) async => _webSocket.send(
    envelope: MessageEnvelope(
      type: .chatLeave,
      payload: .leaveFromChat(chatId: chatId),
    ),
  );
}
