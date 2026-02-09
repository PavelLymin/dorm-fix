import 'dart:async';

import 'message_payload.dart';

typedef MessageEnvelopeMatch<R, E extends MessagePayload> =
    FutureOr<R> Function(E payload, MessageType type);

final class MessageEnvelope {
  const MessageEnvelope({required this.type, required this.payload});

  final MessageType type;
  final MessagePayload payload;

  FutureOr<R?>? mapOrNull<R>({
    MessageEnvelopeMatch<R, JoinToChatPayload>? joinToChat,
    MessageEnvelopeMatch<R, LeaveFromChatPayload>? leaveFromChat,
    MessageEnvelopeMatch<R, CreatedRequestPayload>? createdRequest,
    MessageEnvelopeMatch<R, CreatedMessagePayload>? createdMessage,
  }) async => switch (payload) {
    JoinToChatPayload payload => joinToChat?.call(payload, type),
    LeaveFromChatPayload payload => leaveFromChat?.call(payload, type),
    CreatedRequestPayload payload => createdRequest?.call(payload, type),
    CreatedMessagePayload payload => createdMessage?.call(payload, type),
  };

  Map<String, Object?> toJson() => {
    'type': type.value,
    'payload': payload.toJson(),
  };

  factory MessageEnvelope.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'type': String typeStr,
      'payload': Map<String, Object?> payload,
    }) {
      final type = MessageType.fromString(typeStr);
      return MessageEnvelope(
        type: type,
        payload: MessagePayload.fromJson(type, payload),
      );
    } else {
      throw FormatException('Invalid message envelope: $json');
    }
  }

  @override
  String toString() => 'MessageEnvelope(type: $type, payload: $payload)';
}
