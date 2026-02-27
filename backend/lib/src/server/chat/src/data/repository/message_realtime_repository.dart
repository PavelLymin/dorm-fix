import '../../../../../core/ws/ws.dart';
import '../../../chat.dart';

abstract interface class IMessageRealTimeRepository {
  Future<void> sendMessage({
    required PartialMessage message,
    required int chatId,
  });
}

class MessageRealTimeRepositoryImpl implements IMessageRealTimeRepository {
  MessageRealTimeRepositoryImpl({
    required IChatRealTimeRepository chatRealTimeRepository,
    required IMessageRepository messageRepository,
  }) : _chatRealTimeRepository = chatRealTimeRepository,
       _messageRepository = messageRepository;

  final IChatRealTimeRepository _chatRealTimeRepository;
  final IMessageRepository _messageRepository;

  @override
  Future<void> sendMessage({
    required PartialMessage message,
    required int chatId,
  }) async {
    final createdMessage = await _messageRepository.createMessage(
      message: message,
    );
    final envelope = MessageEnvelope(
      type: .messageCreated,
      payload: .createdMessage(message: createdMessage),
    );
    await _chatRealTimeRepository.broadcastToChat(
      envelope: envelope,
      chatId: message.chatId,
    );
  }
}
