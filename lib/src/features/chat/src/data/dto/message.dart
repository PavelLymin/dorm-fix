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

  Map<String, Object?> toJson();
  MessageEntity toEntity();
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

  factory PartialMessageDto.fromEntity(PartialMessage entity) =>
      PartialMessageDto(
        chatId: entity.chatId,
        uid: entity.uid,
        message: entity.message,
      );

  factory PartialMessageDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'chat_id': final int chatId,
      'uid': final String uid,
      'message': final String message,
    }) {
      return PartialMessageDto(chatId: chatId, uid: uid, message: message);
    }

    throw FormatException('Invalid JSON format for PartialMessageDto', json);
  }
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

  factory FullMessageDto.fromEntity(FullMessage entity) => FullMessageDto(
    chatId: entity.chatId,
    uid: entity.uid,
    message: entity.message,
    id: entity.id,
    createdAt: entity.createdAt,
  );

  factory FullMessageDto.fromJson(Map<String, Object?> json) {
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
    }

    throw FormatException('Invalid JSON format for FullMessageDto', json);
  }
}
