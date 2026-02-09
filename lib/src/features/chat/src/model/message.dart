sealed class MessageEntity {
  const MessageEntity({
    required this.chatId,
    required this.uid,
    required this.message,
  });

  final int chatId;
  final String uid;
  final String message;

  factory MessageEntity.partial({
    required int chatId,
    required String uid,
    required String message,
  }) = PartialMessage;

  factory MessageEntity.full({
    required int chatId,
    required String uid,
    required String message,
    required int id,
    required DateTime createdAt,
  }) = FullMessage;

  MessageEntity copyWith({int? chatId, String? uid, String? message});
}

final class PartialMessage extends MessageEntity {
  const PartialMessage({
    required super.chatId,
    required super.uid,
    required super.message,
  });

  @override
  PartialMessage copyWith({int? chatId, String? uid, String? message}) =>
      PartialMessage(
        chatId: chatId ?? this.chatId,
        uid: uid ?? this.uid,
        message: message ?? this.message,
      );

  @override
  String toString() =>
      'PartialMessage('
      'chatId: $chatId, '
      'uid: $uid, '
      'message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartialMessage &&
          runtimeType == other.runtimeType &&
          chatId == other.chatId &&
          uid == other.uid &&
          message == other.message;

  @override
  int get hashCode => Object.hash(chatId, uid, message);
}

final class FullMessage extends MessageEntity {
  const FullMessage({
    required super.chatId,
    required super.uid,
    required super.message,
    required this.id,
    required this.createdAt,
  });

  final int id;
  final DateTime createdAt;

  @override
  FullMessage copyWith({
    int? id,
    int? chatId,
    String? uid,
    String? message,
    DateTime? createdAt,
  }) => FullMessage(
    id: id ?? this.id,
    chatId: chatId ?? this.chatId,
    uid: uid ?? this.uid,
    message: message ?? this.message,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() =>
      'FullMessage('
      'id: $id, '
      'chatId: $chatId, '
      'uid: $uid, '
      'message: $message, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FullMessage && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
