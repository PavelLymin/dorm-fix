import '../../../../server/chat/chat.dart';
import '../../../../server/repair_request/repair_request.dart';

enum MessageType {
  chatJoin(value: 'chat_join'),
  chatLeave(value: 'chat_leave'),
  chatDeleted(value: 'chat_deleted'),
  chatUpdated(value: 'chat_updated'),
  chatError(value: 'chat_error'),
  requestCreated(value: 'request_created'),
  requestDeleted(value: 'request_deleted'),
  requestUpdated(value: 'request_updated'),
  requestError(value: 'request_error'),
  messageCreated(value: 'message_created'),
  messageDeleted(value: 'message_deleted'),
  messageUpdated(value: 'message_updated'),
  messageError(value: 'message_error');

  const MessageType({required this.value});
  final String value;

  factory MessageType.fromString(String type) => values.firstWhere(
    (element) => element.value == type,
    orElse: () => throw FormatException('Unknown  response type: $type'),
  );
}

sealed class MessagePayload {
  const MessagePayload();

  const factory MessagePayload.joinToChat({required int chatId}) =
      JoinToChatPayload;

  const factory MessagePayload.leaveFromChat({required int chatId}) =
      LeaveFromChatPayload;

  const factory MessagePayload.createdRequest({
    required FullRepairRequest request,
  }) = CreatedRequestPayload;

  const factory MessagePayload.createdMessage({
    required MessageEntity message,
  }) = CreatedMessagePayload;

  Map<String, Object?> toJson();

  factory MessagePayload.fromJson(
    MessageType type,
    Map<String, Object?> json,
  ) => switch (type) {
    .chatJoin => JoinToChatPayload.fromJson(json),
    .chatLeave => LeaveFromChatPayload.fromJson(json),
    .chatDeleted => throw UnimplementedError(),
    .chatUpdated => throw UnimplementedError(),
    .chatError => throw UnimplementedError(),
    .requestCreated => CreatedRequestPayload.fromJson(json),
    .requestDeleted => throw UnimplementedError(),
    .requestUpdated => throw UnimplementedError(),
    .requestError => throw UnimplementedError(),
    .messageCreated => CreatedMessagePayload.fromJson(json),
    .messageDeleted => throw UnimplementedError(),
    .messageUpdated => throw UnimplementedError(),
    .messageError => throw UnimplementedError(),
  };
}

final class JoinToChatPayload extends MessagePayload {
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

final class LeaveFromChatPayload extends MessagePayload {
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

final class CreatedRequestPayload extends MessagePayload {
  const CreatedRequestPayload({required this.request});

  final FullRepairRequest request;

  @override
  Map<String, Object?> toJson() => {
    'request': FullRepairRequestDto.fromEntity(request).toJson(),
  };

  factory CreatedRequestPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'request': Map<String, Object?> request}) {
      return CreatedRequestPayload(
        request: FullRepairRequestDto.fromJson(request).toEntity(),
      );
    } else {
      throw FormatException('Invalid payload for created request: $json');
    }
  }

  @override
  String toString() => 'CreatedRequestPayload(request: $request)';
}

final class CreatedMessagePayload extends MessagePayload {
  const CreatedMessagePayload({required this.message});

  final MessageEntity message;

  @override
  Map<String, Object?> toJson() => {
    'message': MessageDto.fromEntity(message).toJson(),
  };

  factory CreatedMessagePayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'message': Map<String, Object?> message}) {
      return CreatedMessagePayload(
        message: MessageDto.fromJson(message).toEntity(),
      );
    } else {
      throw FormatException('Invalid payload for created message: $json');
    }
  }

  @override
  String toString() => 'CreatedMessagePayload(message: $message)';
}
