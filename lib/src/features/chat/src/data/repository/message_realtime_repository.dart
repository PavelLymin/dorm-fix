import '../../../../../core/ws/ws.dart';
import '../../../chat.dart';

abstract interface class IMessageRealtimeRepository {
  Future<void> sendMessage({required PartialMessage message});
}

class MessageRealTimeRepositoryImpl implements IMessageRealtimeRepository {
  const MessageRealTimeRepositoryImpl({required IWebSocket webSocket})
    : _webSocket = webSocket;

  final IWebSocket _webSocket;

  @override
  Future<void> sendMessage({required PartialMessage message}) async =>
      _webSocket.send(
        envelope: MessageEnvelope(
          type: .messageCreated,
          payload: .createMessage(message: message),
        ),
      );
}
