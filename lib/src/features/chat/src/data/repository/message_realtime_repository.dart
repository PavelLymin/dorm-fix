import '../../../../../core/ws/ws.dart';
import '../../../chat.dart';

abstract interface class IMessageRealtimeRepository {
  Future<void> sendMessage({required PartialMessage message});
}

class MessageRealTimeRepositoryImpl implements IMessageRealtimeRepository {
  const MessageRealTimeRepositoryImpl({required this._webSocket});

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
