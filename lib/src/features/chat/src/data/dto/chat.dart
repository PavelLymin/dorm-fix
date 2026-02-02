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
}

final class PartialChatDto extends ChatDto {
  const PartialChatDto({required super.requestId});

  PartialChatEntity toEntity() => PartialChatEntity(requestId: requestId);

  factory PartialChatDto.fromEntity(PartialChatEntity entity) =>
      PartialChatDto(requestId: entity.requestId);

  Map<String, Object?> toJson() => {'requestId': requestId};

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

  FullChatEntity toEntity() =>
      FullChatEntity(requestId: requestId, id: id, createdAt: createdAt);

  factory FullChatDto.fromEntity(FullChatEntity entity) => FullChatDto(
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
}
