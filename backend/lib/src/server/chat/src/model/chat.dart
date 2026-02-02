sealed class ChatEntity {
  const ChatEntity({required this.requestId});

  final int requestId;

  const factory ChatEntity.partial({required int requestId}) = PartialChat;

  const factory ChatEntity.full({
    required int requestId,
    required int id,
    required DateTime createdAt,
  }) = FullChat;
}

final class PartialChat extends ChatEntity {
  const PartialChat({required super.requestId});

  PartialChat copyWith({int? requestId}) =>
      PartialChat(requestId: requestId ?? this.requestId);

  @override
  String toString() =>
      'PartialChat('
      'requestId: $requestId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartialChat && requestId == other.requestId;

  @override
  int get hashCode => requestId.hashCode;
}

final class FullChat extends ChatEntity {
  const FullChat({
    required super.requestId,
    required this.id,
    required this.createdAt,
  });

  final int id;
  final DateTime createdAt;

  FullChat copyWith({int? id, DateTime? createdAt}) => FullChat(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    requestId: requestId,
  );

  @override
  String toString() =>
      'FullChat('
      'requestId: $requestId, '
      'id: $id, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FullChat && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
