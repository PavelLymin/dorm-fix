import '../../ws.dart';

typedef MessageEnvelopeMatch<R, P extends Payload> =
    R Function(P payload, PayloadType type);

final class MessageEnvelope {
  const MessageEnvelope({required this.type, required this.payload});

  final PayloadType type;
  final Payload payload;

  Map<String, Object?> toJson() => {'type': type.value, 'payload': payload};

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
    } else {
      throw FormatException('Invalid message envelope: $json');
    }
  }

  @override
  String toString() => 'MessageEnvelope(type: \$type, payload: \$payload)';
}
