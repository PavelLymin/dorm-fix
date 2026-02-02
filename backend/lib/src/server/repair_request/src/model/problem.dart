sealed class ProblemEntity {
  const ProblemEntity({required this.requestId, required this.photoPath});

  final int requestId;
  final String photoPath;

  const factory ProblemEntity.full({
    required final int requestId,
    required final String photoPath,
    required final int id,
  }) = FullProblemEntity;

  const factory ProblemEntity.partial({
    required final int requestId,
    required final String photoPath,
  }) = PartialProblemEntity;
}

final class FullProblemEntity extends ProblemEntity {
  const FullProblemEntity({
    required super.requestId,
    required super.photoPath,
    required this.id,
  });

  final int id;

  FullProblemEntity copyWith({int? id, int? requestId, String? photoPath}) =>
      FullProblemEntity(
        id: id ?? this.id,
        requestId: requestId ?? this.requestId,
        photoPath: photoPath ?? this.photoPath,
      );

  @override
  String toString() =>
      'ProblemEntity('
      'id: $id, '
      'requestId: $requestId, '
      'photoPath: $photoPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FullProblemEntity && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

final class PartialProblemEntity extends ProblemEntity {
  const PartialProblemEntity({
    required super.requestId,
    required super.photoPath,
  });

  PartialProblemEntity copyWith({int? requestId, String? photoPath}) =>
      PartialProblemEntity(
        requestId: requestId ?? this.requestId,
        photoPath: photoPath ?? this.photoPath,
      );

  @override
  String toString() =>
      'PartialProblemEntity('
      'requestId: $requestId, '
      'photoPath: $photoPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PartialProblemEntity &&
        other.requestId == requestId &&
        other.photoPath == photoPath;
  }

  @override
  int get hashCode => Object.hash(requestId, photoPath);
}
