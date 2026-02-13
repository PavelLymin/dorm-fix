import '../../../chat.dart';

sealed class ChatDto {
  const ChatDto({required this.requestId});

  final int requestId;

  const factory ChatDto.partial({required int requestId}) = PartialChatDto;

  const factory ChatDto.full({
    required int requestId,
    required int id,
    required DateTime createdAt,
  }) = FullChatDto;

  Map<String, Object?> toJson();
  ChatEntity toEntity();
}

final class PartialChatDto extends ChatDto {
  const PartialChatDto({required super.requestId});

  @override
  PartialChat toEntity() => PartialChat(requestId: requestId);

  @override
  Map<String, Object?> toJson() => {'requestId': requestId};

  factory PartialChatDto.fromEntity(PartialChat entity) =>
      PartialChatDto(requestId: entity.requestId);

  factory PartialChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'requestId': final int requestId}) {
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

  factory FullChatDto.fromEntity(FullChat entity) => FullChatDto(
    requestId: entity.requestId,
    id: entity.id,
    createdAt: entity.createdAt,
  );

  factory FullChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'request_id': final int requestId,
      'id': final int id,
      'created_at': final String createdAt,
    }) {
      return FullChatDto(
        requestId: requestId,
        id: id,
        createdAt: .parse(createdAt),
      );
    }

    throw FormatException('Invalid JSON format for FullChatDto', json);
  }
}
