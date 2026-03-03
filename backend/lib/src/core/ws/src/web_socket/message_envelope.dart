import 'dart:async';

import 'models/payload.dart';

typedef MessageEnvelopeMatch<R, E extends Payload> =
    FutureOr<R> Function(E payload, PayloadType type);

final class MessageEnvelope {
  const MessageEnvelope({required this.type, required this.payload});

  final PayloadType type;
  final Payload payload;

  FutureOr<R?>? mapOrNull<R>({
    MessageEnvelopeMatch<R, ErrorPayload>? error,
    MessageEnvelopeMatch<R, JoinToChatPayload>? joinToChat,
    MessageEnvelopeMatch<R, LeaveFromChatPayload>? leaveFromChat,
    MessageEnvelopeMatch<R, CreatedRequestPayload>? createdRequest,
    MessageEnvelopeMatch<R, CreatedMessagePayload>? createdMessage,
    MessageEnvelopeMatch<R, TypingPayload>? typing,
    MessageEnvelopeMatch<R, PresencePayload>? presence,
  }) async => switch (payload) {
    ErrorPayload payload => error?.call(payload, type),
    JoinToChatPayload payload => joinToChat?.call(payload, type),
    LeaveFromChatPayload payload => leaveFromChat?.call(payload, type),
    CreatedRequestPayload payload => createdRequest?.call(payload, type),
    CreatedMessagePayload payload => createdMessage?.call(payload, type),
    TypingPayload payload => typing?.call(payload, type),
    PresencePayload payload => presence?.call(payload, type),
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
      final type = PayloadType.fromString(typeStr);
      return MessageEnvelope(
        type: type,
        payload: Payload.fromJson(type, payload),
      );
    }

    throw FormatException('Invalid message envelope: $json');
  }

  @override
  String toString() => 'MessageEnvelope(type: $type, payload: $payload)';
}
