class ProblemEntity {
  ProblemEntity({
    required this.id,
    required this.requestId,
    required this.photoPath,
  });

  final int id;
  final int requestId;
  final String photoPath;

  ProblemEntity copyWith({int? id, int? requestId, String? photoPath}) =>
      ProblemEntity(
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
    return other is ProblemEntity && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
