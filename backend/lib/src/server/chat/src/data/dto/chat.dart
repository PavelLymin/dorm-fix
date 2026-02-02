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
}

final class PartialChatDto extends ChatDto {
  const PartialChatDto({required super.requestId});

  PartialChat toEntity() => PartialChat(requestId: requestId);

  factory PartialChatDto.fromEntity(PartialChat entity) =>
      PartialChatDto(requestId: entity.requestId);

  Map<String, Object?> toJson() => {'requestId': requestId};

  factory PartialChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'requestId': int requestId}) {
      return PartialChatDto(requestId: requestId);
    }
    throw FormatException('Invalid JSON format for PartialChatDto', json);
  }

  ChatsCompanion toCompanion() => ChatsCompanion(requestId: Value(requestId));
}

final class FullChatDto extends ChatDto {
  const FullChatDto({
    required super.requestId,
    required this.id,
    required this.createdAt,
  });

  final int id;
  final DateTime createdAt;

  FullChat toEntity() =>
      FullChat(requestId: requestId, id: id, createdAt: createdAt);

  factory FullChatDto.fromEntity(FullChat entity) => FullChatDto(
    requestId: entity.requestId,
    id: entity.id,
    createdAt: entity.createdAt,
  );

  Map<String, Object?> toJson() => {
    'requestId': requestId,
    'id': id,
    'createdAt': createdAt.toLocal().toString(),
  };

  factory FullChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'requestId': int requestId,
      'id': int id,
      'createdAt': String createdAt,
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
