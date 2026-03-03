part of 'payload.dart';

final class ErrorPayload extends Payload {
  const ErrorPayload({required this.message});
  final String message;

  @override
  Map<String, Object?> toJson() => {'message': message};

  factory ErrorPayload.fromJson(Map<String, Object?> json) {
    log(json.toString());
    if (json case <String, Object?>{'message': String message}) {
      return ErrorPayload(message: message);
    }

    throw FormatException('Invalid payload for error: $json');
  }
}
