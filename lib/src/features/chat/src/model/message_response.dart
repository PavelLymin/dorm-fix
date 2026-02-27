import '../../../../core/ws/ws.dart';
import 'message.dart';

sealed class MessageResponse {
  const MessageResponse();

  factory MessageResponse.response(
    MessagePayload payload,
    List<FullMessage> messages,
  ) => switch (payload) {
    CreatedMessagePayload _ => CreatedMessageResponse.fromPayload(
      payload,
      messages,
    ),
  };

  T map<T>({
    required T Function(CreatedMessageResponse) created,
    required T Function(DeletedMessageResponse) deleted,
    required T Function(UpdatedMessageResponse) updated,
    required T Function(ErrorMessageResponse) error,
  }) => switch (this) {
    CreatedMessageResponse response => created(response),
    DeletedMessageResponse response => deleted(response),
    UpdatedMessageResponse response => updated(response),
    ErrorMessageResponse response => error(response),
  };
}

final class CreatedMessageResponse extends MessageResponse {
  const CreatedMessageResponse({required this.messages});

  final List<FullMessage> messages;

  factory CreatedMessageResponse.fromPayload(
    CreatedMessagePayload payload,
    List<FullMessage> messages,
  ) {
    final message = payload.message as FullMessage;
    messages.insert(0, message);

    return CreatedMessageResponse(messages: messages);
  }
}

final class DeletedMessageResponse extends MessageResponse {
  const DeletedMessageResponse({required this.messages});

  final List<FullMessage> messages;

  factory DeletedMessageResponse.fromJson(
    CreatedMessagePayload payload,
    List<FullMessage> messages,
  ) {
    // final id = json['id'] as int;
    // messages.removeWhere((element) => element.id == id);

    return DeletedMessageResponse(messages: messages);
  }
}

final class UpdatedMessageResponse extends MessageResponse {
  const UpdatedMessageResponse({required this.messages});

  final List<FullMessage> messages;

  factory UpdatedMessageResponse.fromJson(
    CreatedMessagePayload payload,
    List<FullMessage> messages,
  ) {
    final message = payload.message as FullMessage;

    final index = messages.indexWhere((element) => element.id == message.id);
    messages[index] = message;

    return UpdatedMessageResponse(messages: messages);
  }
}

final class ErrorMessageResponse extends MessageResponse {
  const ErrorMessageResponse({required this.message, required this.messages});

  final String message;
  final List<FullMessage> messages;

  factory ErrorMessageResponse.fromJson(
    CreatedMessagePayload payload,
    List<FullMessage> messages,
  ) {
    return ErrorMessageResponse(message: 'message', messages: messages);
  }
}
