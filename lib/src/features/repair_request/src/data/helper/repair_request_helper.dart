import 'package:dorm_fix/src/core/ws/ws.dart';
import 'package:dorm_fix/src/features/repair_request/request.dart';

enum ResponseType {
  created(value: 'request_created'),
  deleted(value: 'request_deleted'),
  updated(value: 'request_updated'),
  error(value: 'request_error');

  const ResponseType({required this.value});
  final String value;

  factory ResponseType.fromValue(String type) {
    return ResponseType.values.firstWhere(
      (element) => element.value == type,
      orElse: () => throw ArgumentError('Unknown  response type: $type'),
    );
  }
}

sealed class RepairRequestResponse {
  const RepairRequestResponse({required this.type});

  final ResponseType type;

  factory RepairRequestResponse.response(
    MessageEnvelope json,
    List<FullRepairRequest> requests,
  ) {
    final type = ResponseType.fromValue(json.type);

    return switch (type) {
      .created => CreatedRepairRequestResponse.fromJson(json.payload, requests),
      .deleted => DeletedRepairRequestResponse.fromJson(json.payload, requests),
      .updated => UpdatedRepairRequestResponse.fromJson(json.payload, requests),
      .error => UpdatedRepairRequestResponse.fromJson(json.payload, requests),
    };
  }

  T map<T>({
    required T Function(CreatedRepairRequestResponse) created,
    required T Function(DeletedRepairRequestResponse) deleted,
    required T Function(UpdatedRepairRequestResponse) updated,
  }) => switch (type) {
    .created => created(this as CreatedRepairRequestResponse),
    .deleted => deleted(this as DeletedRepairRequestResponse),
    .updated => updated(this as UpdatedRepairRequestResponse),
    .error => updated(this as UpdatedRepairRequestResponse),
  };
}

final class CreatedRepairRequestResponse extends RepairRequestResponse {
  const CreatedRepairRequestResponse({
    super.type = .created,
    required this.requests,
  });

  final List<FullRepairRequest> requests;

  factory CreatedRepairRequestResponse.fromJson(
    Map<String, Object?> json,
    List<FullRepairRequest> requests,
  ) {
    final request = FullRepairRequestDto.fromJson(json).toEntity();
    requests.add(request);

    return CreatedRepairRequestResponse(requests: requests);
  }
}

final class DeletedRepairRequestResponse extends RepairRequestResponse {
  const DeletedRepairRequestResponse({
    super.type = .deleted,
    required this.requests,
  });

  final List<FullRepairRequest> requests;

  factory DeletedRepairRequestResponse.fromJson(
    Map<String, Object?> json,
    List<FullRepairRequest> requests,
  ) {
    final id = json['id'] as int;
    requests.removeWhere((element) => element.id == id);

    return DeletedRepairRequestResponse(requests: requests);
  }
}

final class UpdatedRepairRequestResponse extends RepairRequestResponse {
  const UpdatedRepairRequestResponse({
    super.type = .updated,
    required this.requests,
  });

  final List<FullRepairRequest> requests;

  factory UpdatedRepairRequestResponse.fromJson(
    Map<String, Object?> json,
    List<FullRepairRequest> requests,
  ) {
    final request = FullRepairRequestDto.fromJson(json).toEntity();

    final index = requests.indexWhere((element) => element.id == request.id);
    requests[index] = request;

    return UpdatedRepairRequestResponse(requests: requests);
  }
}

final class ErrorRepairRequestResponse extends RepairRequestResponse {
  const ErrorRepairRequestResponse({
    super.type = .error,
    required this.message,
    required this.requests,
  });

  final String message;
  final List<FullRepairRequest> requests;

  factory ErrorRepairRequestResponse.fromJson(
    Map<String, Object?> json,
    List<FullRepairRequest> requests,
  ) {
    final payload = json['payload'] as Map<String, Object?>;

    final message = payload['message'] as String;

    return ErrorRepairRequestResponse(message: message, requests: requests);
  }
}
