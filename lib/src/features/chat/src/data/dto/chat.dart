import '../../../chat.dart';

final class ChatDto {
  const ChatDto({required this.id, required this.createdAt});

  final int id;
  final DateTime createdAt;

  ChatEntity toEntity() => ChatEntity(id: id, createdAt: createdAt);

  Map<String, Object?> toJson() => {
    'id': id,
    'created_at': createdAt.toLocal().toString(),
  };

  factory ChatDto.fromEntity(ChatEntity entity) =>
      ChatDto(id: entity.id, createdAt: entity.createdAt);

  factory ChatDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'created_at': final String createdAt,
    }) {
      return ChatDto(id: id, createdAt: .parse(createdAt));
    }

    throw FormatException('Invalid JSON format for FullChatDto', json);
  }
}
