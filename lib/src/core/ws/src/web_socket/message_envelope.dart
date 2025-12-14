final class MessageEnvelope {
  const MessageEnvelope({required this.type, required this.payload});

  final String type;
  final Map<String, Object?> payload;

  Map<String, Object?> toJson() => {'type': type, 'payload': payload};

  static MessageEnvelope fromJson(Map<String, Object?> json) {
    final typeObj = json['type'];
    if (typeObj is! String) {
      throw FormatException('Invalid message: "type" is not a String');
    }

    final payloadObj = json['payload'];
    if (payloadObj == null) {
      return MessageEnvelope(type: typeObj, payload: {});
    }

    if (payloadObj is Map<String, Object?>) {
      return MessageEnvelope(type: typeObj, payload: payloadObj);
    }

    throw FormatException('Invalid message: "payload" is not a Map');
  }

  @override
  String toString() => 'MessageEnvelope(type: \$type, payload: \$payload)';
}
