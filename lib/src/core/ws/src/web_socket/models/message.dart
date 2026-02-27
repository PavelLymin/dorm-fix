part of 'payload.dart';

sealed class MessagePayload extends Payload {
  const MessagePayload();

  const factory MessagePayload.created({required FullMessage message}) =
      CreatedMessagePayload;
}

final class CreatedMessagePayload extends MessagePayload {
  const CreatedMessagePayload({required this.message});

  final MessageEntity message;

  @override
  Map<String, Object?> toJson() => {
    'message': message is FullMessage
        ? FullMessageDto.fromEntity(message as FullMessage).toJson()
        : PartialMessageDto.fromEntity(message as PartialMessage).toJson(),
  };

  factory CreatedMessagePayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'message': Map<String, Object?> message}) {
      if (message['id'] == null) {
        return CreatedMessagePayload(
          message: PartialMessageDto.fromJson(message).toEntity(),
        );
      }

      return CreatedMessagePayload(
        message: FullMessageDto.fromJson(message).toEntity(),
      );
    }

    throw FormatException('Invalid payload for created message: $json');
  }

  @override
  String toString() => 'CreatedMessagePayload(message: $message)';
}
