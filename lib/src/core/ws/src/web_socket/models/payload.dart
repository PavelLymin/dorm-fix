import '../../../../../features/chat/chat.dart';

part 'message.dart';
part 'chat.dart';
part 'typing.dart';
part 'error.dart';

enum PayloadType {
  error(value: 'error'),
  chatJoin(value: 'chat_join'),
  chatLeave(value: 'chat_leave'),
  messageCreated(value: 'message_created'),
  messageDeleted(value: 'message_deleted'),
  messageUpdated(value: 'message_updated'),
  typing(value: 'typing');

  const PayloadType({required this.value});
  final String value;

  factory PayloadType.fromString(String type) => values.firstWhere(
    (element) => element.value == type,
    orElse: () => throw FormatException('Unknown  response type: $type'),
  );
}

sealed class Payload {
  const Payload();

  const factory Payload.typing({required int chatId, required bool isStarted}) =
      TypingPayload;

  const factory Payload.joinToChat({required int chatId}) = JoinToChatPayload;

  const factory Payload.leaveFromChat({required int chatId}) =
      LeaveFromChatPayload;

  const factory Payload.createMessage({required MessageEntity message}) =
      CreatedMessagePayload;

  Map<String, Object?> toJson();

  factory Payload.fromJson(PayloadType type, Map<String, Object?> json) =>
      switch (type) {
        .error => ErrorPayload.fromJson(json),
        .typing => TypingPayload.fromJson(json),
        .chatJoin => JoinToChatPayload.fromJson(json),
        .chatLeave => LeaveFromChatPayload.fromJson(json),
        .messageCreated => CreatedMessagePayload.fromJson(json),
        .messageDeleted => throw UnimplementedError(),
        .messageUpdated => throw UnimplementedError(),
      };
}
