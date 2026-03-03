part of 'payload.dart';

final class TypingPayload extends Payload {
  const TypingPayload({required this.chatId, required this.isStarted});

  final int chatId;
  final bool isStarted;

  @override
  Map<String, Object?> toJson() => {'chat_id': chatId, 'is_started': isStarted};

  factory TypingPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'chat_id': int chatId,
      'is_started': bool isStarted,
    }) {
      return TypingPayload(chatId: chatId, isStarted: isStarted);
    }

    throw FormatException('Invalid payload for typing: $json');
  }
}
