part of 'payload.dart';

final class JoinToChatPayload extends Payload {
  const JoinToChatPayload({required this.chatId});

  final int chatId;

  @override
  Map<String, Object?> toJson() => {'chat_id': chatId};

  factory JoinToChatPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'chat_id': int chatId}) {
      return JoinToChatPayload(chatId: chatId);
    }

    throw FormatException('Invalid payload for join to chat: $json');
  }

  @override
  String toString() => 'JoinToChatPayload(chatId: $chatId)';
}

final class LeaveFromChatPayload extends Payload {
  const LeaveFromChatPayload({required this.chatId});

  final int chatId;

  @override
  Map<String, Object?> toJson() => {'chat_id': chatId};

  factory LeaveFromChatPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'chat_id': int chatId}) {
      return LeaveFromChatPayload(chatId: chatId);
    }

    throw FormatException('Invalid payload for leave from chat: $json');
  }

  @override
  String toString() => 'LeaveFromChatPayload(chatId: $chatId)';
}
