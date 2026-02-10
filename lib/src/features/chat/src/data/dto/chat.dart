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

  factory ChatDto.fromEntity(ChatEntity entity) => switch (entity) {
    PartialChat chat => ChatDto.partial(requestId: chat.requestId),
    FullChat chat => ChatDto.full(
      requestId: chat.requestId,
      id: chat.id,
      createdAt: chat.createdAt,
    ),
  };

  factory ChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'requestId': final int requestId,
      'id': final int id,
      'created_at': final String createdAt,
    }) {
      return FullChatDto(
        requestId: requestId,
        id: id,
        createdAt: .parse(createdAt),
      );
    } else if (json case <String, Object?>{'requestId': final int requestId}) {
      return PartialChatDto(requestId: requestId);
    }
    throw FormatException('Invalid JSON format for MessageDto', json);
  }
}

final class PartialChatDto extends ChatDto {
  const PartialChatDto({required super.requestId});

  @override
  PartialChat toEntity() => PartialChat(requestId: requestId);

  @override
  Map<String, Object?> toJson() => {'requestId': requestId};
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
    'requestId': requestId,
    'id': id,
    'createdAt': createdAt.toLocal().toString(),
  };
}
