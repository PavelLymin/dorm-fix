final class ChatEntity {
  const ChatEntity({required this.id, required this.createdAt});

  final int id;
  final DateTime createdAt;

  ChatEntity copyWith({int? id, DateTime? createdAt}) =>
      ChatEntity(id: id ?? this.id, createdAt: createdAt ?? this.createdAt);

  @override
  String toString() =>
      'FullChat('
      'id: $id, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ChatEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
