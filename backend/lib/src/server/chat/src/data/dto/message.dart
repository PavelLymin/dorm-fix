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
}

final class PartialMessageDto extends MessageDto {
  const PartialMessageDto({
    required super.chatId,
    required super.uid,
    required super.message,
  });

  PartialMessage toEntity() =>
      PartialMessage(chatId: chatId, uid: uid, message: message);

  factory PartialMessageDto.fromEntity(PartialMessage message) =>
      PartialMessageDto(
        chatId: message.chatId,
        uid: message.uid,
        message: message.message,
      );

  Map<String, Object?> toJson() => {
    'chat_id': chatId,
    'uid': uid,
    'message': message,
  };

  factory PartialMessageDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'chat_id': final int chatId,
      'uid': final String uid,
      'message': final String message,
    }) {
      return PartialMessageDto(chatId: chatId, uid: uid, message: message);
    } else {
      throw FormatException('Invalid JSON format for PartialMessageDto', json);
    }
  }

  MessagesCompanion toCompanion() => MessagesCompanion(
    chatId: Value(chatId),
    uid: Value(uid),
    message: Value(message),
  );
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

  FullMessage toEntity() => FullMessage(
    chatId: chatId,
    uid: uid,
    message: message,
    id: id,
    createdAt: createdAt,
  );

  factory FullMessageDto.fromEntity(FullMessage message) => FullMessageDto(
    chatId: message.chatId,
    uid: message.uid,
    message: message.message,
    id: message.id,
    createdAt: message.createdAt,
  );

  Map<String, Object?> toJson() => {
    'chat_id': chatId,
    'uid': uid,
    'message': message,
    'id': id,
    'created_at': createdAt.toLocal().toString(),
  };

  factory FullMessageDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'chat_id': final int chatId,
      'uid': final String uid,
      'message': final String message,
      'id': final int id,
      'created_at': final String createdAtStr,
    }) {
      final createdAt = DateTime.parse(createdAtStr).toUtc();
      return FullMessageDto(
        chatId: chatId,
        uid: uid,
        message: message,
        id: id,
        createdAt: createdAt,
      );
    } else {
      throw FormatException('Invalid JSON format for FullMessageDto', json);
    }
  }

  factory FullMessageDto.fromData({required Message message}) => FullMessageDto(
    chatId: message.chatId,
    uid: message.uid,
    message: message.message,
    id: message.id,
    createdAt: message.createdAt,
  );
}
