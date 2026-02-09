import '../../../chat.dart';

sealed class MessageDto {
  const MessageDto({
    required this.chatId,
    required this.uid,
    required this.message,
  });

  final int chatId;
  final String uid;
  final String message;

  Map<String, Object?> toJson();
  MessageEntity toEntity();

  factory MessageDto.partial({
    required int chatId,
    required String uid,
    required String message,
  }) = PartialMessageDto;

  factory MessageDto.full({
    required int chatId,
    required String uid,
    required String message,
    required int id,
    required DateTime createdAt,
  }) = FullMessageDto;

  factory MessageDto.fromEntity(MessageEntity entity) => switch (entity) {
    FullMessage message => MessageDto.full(
      chatId: message.chatId,
      uid: message.uid,
      message: message.message,
      id: message.id,
      createdAt: message.createdAt,
    ),
    PartialMessage message => MessageDto.partial(
      chatId: message.chatId,
      uid: message.uid,
      message: message.message,
    ),
  };

  factory MessageDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'chat_id': final int chatId,
      'uid': final String uid,
      'message': final String message,
      'id': final int id,
      'created_at': final String createdAt,
    }) {
      return FullMessageDto(
        chatId: chatId,
        uid: uid,
        message: message,
        id: id,
        createdAt: .parse(createdAt),
      );
    } else if (json case <String, Object?>{
      'chat_id': final int chatId,
      'uid': final String uid,
      'message': final String message,
    }) {
      return PartialMessageDto(chatId: chatId, uid: uid, message: message);
    } else {
      throw FormatException('Invalid JSON format for MessageDto', json);
    }
  }
}

final class PartialMessageDto extends MessageDto {
  const PartialMessageDto({
    required super.chatId,
    required super.uid,
    required super.message,
  });

  @override
  PartialMessage toEntity() =>
      PartialMessage(chatId: chatId, uid: uid, message: message);

  @override
  Map<String, Object?> toJson() => {
    'chat_id': chatId,
    'uid': uid,
    'message': message,
  };
}

final class FullMessageDto extends MessageDto {
  const FullMessageDto({
    required super.chatId,
    required super.uid,
    required super.message,
    required this.id,
    required this.createdAt,
  });

  final int id;
  final DateTime createdAt;

  @override
  FullMessage toEntity() => FullMessage(
    chatId: chatId,
    uid: uid,
    message: message,
    id: id,
    createdAt: createdAt,
  );

  @override
  Map<String, Object?> toJson() => {
    'chat_id': chatId,
    'uid': uid,
    'message': message,
    'id': id,
    'created_at': createdAt.toLocal().toString(),
  };
}
