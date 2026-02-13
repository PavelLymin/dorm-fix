sealed class ProblemEntity {
  const ProblemEntity({required this.requestId, required this.photoPath});

  final int requestId;
  final String photoPath;

  const factory ProblemEntity.full({
    required final int requestId,
    required final String photoPath,
    required final int id,
  }) = FullProblem;

  const factory ProblemEntity.partial({
    required final int requestId,
    required final String photoPath,
  }) = PartialProblem;
}

final class FullProblem extends ProblemEntity {
  const FullProblem({
    required super.requestId,
    required super.photoPath,
    required this.id,
  });

  final int id;

  FullProblem copyWith({int? id, int? requestId, String? photoPath}) =>
      FullProblem(
        id: id ?? this.id,
        requestId: requestId ?? this.requestId,
        photoPath: photoPath ?? this.photoPath,
      );

  @override
  String toString() =>
      'FullProblem('
      'id: $id, '
      'requestId: $requestId, '
      'photoPath: $photoPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FullProblem && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

final class PartialProblem extends ProblemEntity {
  const PartialProblem({required super.requestId, required super.photoPath});

  PartialProblem copyWith({int? requestId, String? photoPath}) =>
      PartialProblem(
        requestId: requestId ?? this.requestId,
        photoPath: photoPath ?? this.photoPath,
      );

  @override
  String toString() =>
      'PartialProblem('
      'requestId: $requestId, '
      'photoPath: $photoPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PartialProblem &&
        other.requestId == requestId &&
        other.photoPath == photoPath;
  }

  @override
  int get hashCode => Object.hash(requestId, photoPath);
}
