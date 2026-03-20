import '../../../../../core/ws/ws.dart';

abstract interface class ITypingRealTimeRepository {
  Future<void> startTypig({required int chatId});

  Future<void> stopTypig({required int chatId});
}

class TypingRealTimeRepositoryImpl implements ITypingRealTimeRepository {
  const TypingRealTimeRepositoryImpl({required this._webSocket});

  final IWebSocket _webSocket;

  @override
  Future<void> startTypig({required int chatId}) async => _webSocket.send(
    envelope: MessageEnvelope(
      type: .typing,
      payload: .typing(chatId: chatId, isStarted: true),
    ),
  );

  @override
  Future<void> stopTypig({required int chatId}) async => _webSocket.send(
    envelope: MessageEnvelope(
      type: .typing,
      payload: .typing(chatId: chatId, isStarted: false),
    ),
  );
}
