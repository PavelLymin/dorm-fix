import '../../../../core/ws/ws.dart';
import '../../request.dart';

sealed class RepairRequestResponse {
  const RepairRequestResponse();

  factory RepairRequestResponse.response(
    RepairRequestPayload payload,
    List<FullRepairRequest> requests,
  ) {
    return switch (payload) {
      CreatedRequestPayload _ => CreatedRepairRequestResponse.fromPayload(
        payload,
        requests,
      ),
      DeletedRequestPayload _ => DeletedRepairRequestResponse.fromPayload(
        payload,
        requests,
      ),
      UpdatedRequestPayload _ => UpdatedRepairRequestResponse.fromPayload(
        payload,
        requests,
      ),
      ErrorRepairRequestPayload _ => ErrorRepairRequestResponse.fromPayload(
        payload,
        requests,
      ),
    };
  }

  T map<T>({
    required T Function(CreatedRepairRequestResponse) created,
    required T Function(DeletedRepairRequestResponse) deleted,
    required T Function(UpdatedRepairRequestResponse) updated,
    required T Function(ErrorRepairRequestResponse) error,
  }) => switch (this) {
    CreatedRepairRequestResponse response => created(response),
    DeletedRepairRequestResponse response => deleted(response),
    UpdatedRepairRequestResponse response => updated(response),
    ErrorRepairRequestResponse response => error(response),
  };
}

final class CreatedRepairRequestResponse extends RepairRequestResponse {
  const CreatedRepairRequestResponse({required this.requests});

  final List<FullRepairRequest> requests;

  factory CreatedRepairRequestResponse.fromPayload(
    CreatedRequestPayload payload,
    List<FullRepairRequest> requests,
  ) {
    final request = payload.request;
    requests.add(request);

    return CreatedRepairRequestResponse(requests: requests);
  }
}

final class DeletedRepairRequestResponse extends RepairRequestResponse {
  const DeletedRepairRequestResponse({required this.requests});

  final List<FullRepairRequest> requests;

  factory DeletedRepairRequestResponse.fromPayload(
    DeletedRequestPayload payload,
    List<FullRepairRequest> requests,
  ) {
    final id = payload.id;
    requests.removeWhere((element) => element.id == id);

    return DeletedRepairRequestResponse(requests: requests);
  }
}

final class UpdatedRepairRequestResponse extends RepairRequestResponse {
  const UpdatedRepairRequestResponse({required this.requests});

  final List<FullRepairRequest> requests;

  factory UpdatedRepairRequestResponse.fromPayload(
    UpdatedRequestPayload payload,
    List<FullRepairRequest> requests,
  ) {
    final request = payload.request;

    final index = requests.indexWhere((element) => element.id == request.id);
    requests[index] = request;

    return UpdatedRepairRequestResponse(requests: requests);
  }
}

final class ErrorRepairRequestResponse extends RepairRequestResponse {
  const ErrorRepairRequestResponse({
    required this.message,
    required this.requests,
  });

  final String message;
  final List<FullRepairRequest> requests;

  factory ErrorRepairRequestResponse.fromPayload(
    ErrorRepairRequestPayload payload,
    List<FullRepairRequest> requests,
  ) {
    final message = payload.message;

    return ErrorRepairRequestResponse(message: message, requests: requests);
  }
}
