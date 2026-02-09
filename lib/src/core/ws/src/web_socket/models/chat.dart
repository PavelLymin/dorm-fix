part of 'payload.dart';

sealed class ChatPayload extends Payload {
  const ChatPayload();

  const factory ChatPayload.joinToChat({required int chatId}) =
      JoinToChatPayload;

  const factory ChatPayload.leaveFromChat({required int chatId}) =
      LeaveFromChatPayload;
}

final class JoinToChatPayload extends ChatPayload {
  const JoinToChatPayload({required this.chatId});

  final int chatId;

  @override
  Map<String, Object?> toJson() => {'chat_id': chatId};

  factory JoinToChatPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'chat_id': int chatId}) {
      return JoinToChatPayload(chatId: chatId);
    } else {
      throw FormatException('Invalid payload for join to chat: $json');
    }
  }

  @override
  String toString() => 'JoinToChatPayload(chatId: $chatId)';
}

final class LeaveFromChatPayload extends ChatPayload {
  const LeaveFromChatPayload({required this.chatId});

  final int chatId;

  @override
  Map<String, Object?> toJson() => {'chat_id': chatId};

  factory LeaveFromChatPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'chat_id': int chatId}) {
      return LeaveFromChatPayload(chatId: chatId);
    } else {
      throw FormatException('Invalid payload for leave from chat: $json');
    }
  }

  @override
  String toString() => 'LeaveFromChatPayload(chatId: $chatId)';
}
