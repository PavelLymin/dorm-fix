import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
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
  MessagesCompanion toCompanion();

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

  @override
  MessagesCompanion toCompanion() => MessagesCompanion(
    chatId: Value(chatId),
    uid: Value(uid),
    message: Value(message),
  );

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

  @override
  MessagesCompanion toCompanion() => MessagesCompanion(
    chatId: Value(chatId),
    uid: Value(uid),
    message: Value(message),
    id: Value(id),
    createdAt: Value(createdAt),
  );

  factory FullMessageDto.fromEntity(FullMessage entity) => FullMessageDto(
    id: entity.id,
    chatId: entity.chatId,
    uid: entity.uid,
    message: entity.message,
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

  factory FullMessageDto.fromData({required Message message}) => FullMessageDto(
    chatId: message.chatId,
    uid: message.uid,
    message: message.message,
    id: message.id,
    createdAt: message.createdAt,
  );
}
