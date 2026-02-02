sealed class ChatEntity {
  const ChatEntity({required this.requestId});

  final int requestId;

  const factory ChatEntity.partial({required int requestId}) =
      PartialChatEntity;

  const factory ChatEntity.full({
    required int requestId,
    required int id,
    required DateTime createdAt,
  }) = FullChatEntity;
}

final class PartialChatEntity extends ChatEntity {
  const PartialChatEntity({required super.requestId});

  PartialChatEntity copyWith({int? requestId}) =>
      PartialChatEntity(requestId: requestId ?? this.requestId);

  @override
  String toString() =>
      'PartialChatEntity('
      'requestId: $requestId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartialChatEntity && requestId == other.requestId;

  @override
  int get hashCode => requestId.hashCode;
}

final class FullChatEntity extends ChatEntity {
  const FullChatEntity({
    required super.requestId,
    required this.id,
    required this.createdAt,
  });

  final int id;
  final DateTime createdAt;

  FullChatEntity copyWith({int? id, DateTime? createdAt}) => FullChatEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    requestId: requestId,
  );

  @override
  String toString() =>
      'FullChatEntity('
      'requestId: $requestId, '
      'id: $id, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FullChatEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
