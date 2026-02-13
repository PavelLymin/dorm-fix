import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';
import '../../model/chat.dart';

sealed class ChatDto {
  const ChatDto({required this.requestId});

  final int requestId;

  const factory ChatDto.partial({required int requestId}) = PartialChatDto;

  const factory ChatDto.full({
    required int requestId,
    required int id,
    required DateTime createdAt,
  }) = FullChatDto;

  ChatEntity toEntity();
  Map<String, Object?> toJson();
  ChatsCompanion toCompanion();
}

final class PartialChatDto extends ChatDto {
  const PartialChatDto({required super.requestId});

  @override
  PartialChat toEntity() => PartialChat(requestId: requestId);

  @override
  Map<String, Object?> toJson() => {'requestId': requestId};

  @override
  ChatsCompanion toCompanion() => ChatsCompanion(requestId: Value(requestId));

  factory PartialChatDto.fromEntity(PartialChat entity) =>
      PartialChatDto(requestId: entity.requestId);

  factory PartialChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'requestId': int requestId}) {
      return PartialChatDto(requestId: requestId);
    }
    throw FormatException('Invalid JSON format for PartialChatDto', json);
  }
}

final class FullChatDto extends ChatDto {
  const FullChatDto({
    required super.requestId,
    required this.id,
    required this.createdAt,
  });

  final int id;
  final DateTime createdAt;

  @override
  FullChat toEntity() =>
      FullChat(requestId: requestId, id: id, createdAt: createdAt);

  @override
  Map<String, Object?> toJson() => {
    'request_id': requestId,
    'id': id,
    'created_at': createdAt.toLocal().toString(),
  };

  @override
  ChatsCompanion toCompanion() => ChatsCompanion(
    requestId: Value(requestId),
    id: Value(id),
    createdAt: Value(createdAt),
  );

  factory FullChatDto.fromEntity(FullChat entity) => FullChatDto(
    requestId: entity.requestId,
    id: entity.id,
    createdAt: entity.createdAt,
  );

  factory FullChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'request_id': int requestId,
      'id': int id,
      'created_at': String createdAt,
    }) {
      return FullChatDto(
        requestId: requestId,
        id: id,
        createdAt: .parse(createdAt),
      );
    }
    throw FormatException('Invalid JSON format for FullChatDto', json);
  }

  factory FullChatDto.fromData({required Chat chat}) => FullChatDto(
    requestId: chat.requestId,
    id: chat.id,
    createdAt: chat.createdAt,
  );
}
