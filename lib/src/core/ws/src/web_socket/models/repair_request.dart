part of 'payload.dart';

sealed class RepairRequestPayload extends Payload {
  const RepairRequestPayload();

  const factory RepairRequestPayload.created({
    required FullRepairRequest request,
  }) = CreatedRequestPayload;

  const factory RepairRequestPayload.deleted({required int id}) =
      DeletedRequestPayload;

  const factory RepairRequestPayload.updated({
    required FullRepairRequest request,
  }) = UpdatedRequestPayload;

  const factory RepairRequestPayload.error({required String message}) =
      ErrorRepairRequestPayload;
}

final class CreatedRequestPayload extends RepairRequestPayload {
  const CreatedRequestPayload({required this.request});

  final FullRepairRequest request;

  @override
  Map<String, Object?> toJson() => {
    'request': RepairRequestDto.fromEntity(request).toJson(),
  };

  factory CreatedRequestPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'request': Map<String, Object?> request}) {
      return CreatedRequestPayload(
        request:
            RepairRequestDto.fromJson(request).toEntity() as FullRepairRequest,
      );
    } else {
      throw FormatException('Invalid payload for created request: $json');
    }
  }

  @override
  String toString() => 'CreatedRequestPayload(request: $request)';
}

final class DeletedRequestPayload extends RepairRequestPayload {
  const DeletedRequestPayload({required this.id});

  final int id;

  @override
  Map<String, Object?> toJson() => {'id': id};

  factory DeletedRequestPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'id': int id}) {
      return DeletedRequestPayload(id: id);
    } else {
      throw FormatException('Invalid payload for deleted request: $json');
    }
  }

  @override
  String toString() => 'DeletedRequestPayload(id: $id)';
}

final class UpdatedRequestPayload extends RepairRequestPayload {
  const UpdatedRequestPayload({required this.request});

  final FullRepairRequest request;

  @override
  Map<String, Object?> toJson() => {
    'request': RepairRequestDto.fromEntity(request).toJson(),
  };

  factory UpdatedRequestPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'request': Map<String, Object?> request}) {
      return UpdatedRequestPayload(
        request:
            RepairRequestDto.fromJson(request).toEntity() as FullRepairRequest,
      );
    } else {
      throw FormatException('Invalid payload for updated request: $json');
    }
  }

  @override
  String toString() => 'UpdatedRequestPayload(request: $request)';
}

final class ErrorRepairRequestPayload extends RepairRequestPayload {
  const ErrorRepairRequestPayload({required this.message});

  final String message;

  @override
  Map<String, Object?> toJson() => {'error': message};

  factory ErrorRepairRequestPayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{'error': String message}) {
      return ErrorRepairRequestPayload(message: message);
    } else {
      throw FormatException('Invalid payload for error request: $json');
    }
  }

  @override
  String toString() => 'ErrorRepairRequestPayload(message: $message)';
}
