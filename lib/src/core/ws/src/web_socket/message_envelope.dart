import '../../ws.dart';

typedef MessageEnvelopeMatch<R, P extends Payload> =
    R Function(P payload, MessageType type);

final class MessageEnvelope {
  const MessageEnvelope({required this.type, required this.payload});

  final MessageType type;
  final Payload payload;

  Map<String, Object?> toJson() => {'type': type, 'payload': payload};

  factory MessageEnvelope.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'type': String typeStr,
      'payload': Map<String, Object?> payload,
    }) {
      final type = MessageType.fromString(typeStr);
      return MessageEnvelope(
        type: type,
        payload: Payload.fromJson(type, payload),
      );
    } else {
      throw FormatException('Invalid message envelope: $json');
    }
  }

  @override
  String toString() => 'MessageEnvelope(type: \$type, payload: \$payload)';
}
