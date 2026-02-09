import '../../../../../features/chat/chat.dart';
import '../../../../../features/repair_request/request.dart';

part 'repair_request.dart';
part 'message.dart';
part 'chat.dart';

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

sealed class Payload {
  const Payload();

  Map<String, Object?> toJson();

  factory Payload.fromJson(MessageType type, Map<String, Object?> json) =>
      switch (type) {
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
