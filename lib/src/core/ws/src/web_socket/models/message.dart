part of 'payload.dart';

sealed class MessagePayload extends Payload {
  const MessagePayload();

  const factory MessagePayload.created({required MessageEntity message}) =
      CreatedMessagePayload;
}

final class CreatedMessagePayload extends MessagePayload {
  const CreatedMessagePayload({required this.message});

  final MessageEntity message;

  @override
  Map<String, Object?> toJson() => {
    'message': MessageDto.fromEntity(message).toJson(),
  };

  factory CreatedMessagePayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'message': Map<String, Object?> message}) {
      return CreatedMessagePayload(
        message: MessageDto.fromJson(message).toEntity(),
      );
    } else {
      throw FormatException('Invalid payload for created message: $json');
    }
  }

  @override
  String toString() => 'CreatedMessagePayload(message: $message)';
}
