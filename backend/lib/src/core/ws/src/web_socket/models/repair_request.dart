part of 'payload.dart';

final class CreatedRequestPayload extends Payload {
  const CreatedRequestPayload({required this.request});

  final RequestAggregate request;

  @override
  Map<String, Object?> toJson() => {
    'request': RequestAggregateDto.fromEntity(request).toJson(),
  };

  factory CreatedRequestPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'request': Map<String, Object?> request}) {
      return CreatedRequestPayload(
        request: RequestAggregateDto.fromJson(request).toEntity(),
      );
    }

    throw FormatException('Invalid payload for created request: $json');
  }

  @override
  String toString() => 'CreatedRequestPayload(request: $request)';
}
