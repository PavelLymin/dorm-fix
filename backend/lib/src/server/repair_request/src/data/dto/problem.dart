import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../model/problem.dart';

sealed class ProblemDto {
  const ProblemDto({required this.requestId, required this.photoPath});

  final int requestId;
  final String photoPath;

  const factory ProblemDto.partial({
    required final int requestId,
    required final String photoPath,
  }) = PartialProblemDto;

  const factory ProblemDto.full({
    required final int id,
    required final int requestId,
    required final String photoPath,
  }) = FullProblemDto;

  ProblemEntity toEntity();

  Map<String, Object?> toJson();
}

class PartialProblemDto extends ProblemDto {
  const PartialProblemDto({required super.requestId, required super.photoPath});

  @override
  PartialProblem toEntity() =>
      PartialProblem(requestId: requestId, photoPath: photoPath);

  @override
  Map<String, Object?> toJson() => {
    'request_id': requestId,
    'photo_path': photoPath,
  };

  ProblemsCompanion toCompanion() => ProblemsCompanion(
    requestId: Value(requestId),
    photoPath: Value(photoPath),
  );

  factory PartialProblemDto.fromEntity(PartialProblem entity) =>
      PartialProblemDto(
        requestId: entity.requestId,
        photoPath: entity.photoPath,
      );

  factory PartialProblemDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'request_id': final int requestId,
      'photo_path': final String photoPath,
    }) {
      return PartialProblemDto(requestId: requestId, photoPath: photoPath);
    }

    throw ArgumentError('Invalid JSON format for PartialProblemDto: $json');
  }
}

class FullProblemDto extends ProblemDto {
  const FullProblemDto({
    required super.requestId,
    required super.photoPath,
    required this.id,
  });

  final int id;

  @override
  FullProblem toEntity() =>
      FullProblem(id: id, requestId: requestId, photoPath: photoPath);

  @override
  Map<String, Object?> toJson() => {
    'id': id,
    'request_id': requestId,
    'photo_path': photoPath,
  };

  ProblemsCompanion toCompanion() => ProblemsCompanion(
    id: Value(id),
    requestId: Value(requestId),
    photoPath: Value(photoPath),
  );

  factory FullProblemDto.fromEntity(FullProblem entity) => FullProblemDto(
    id: entity.id,
    requestId: entity.requestId,
    photoPath: entity.photoPath,
  );

  factory FullProblemDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'request_id': final int requestId,
      'photo_path': final String photoPath,
    }) {
      return FullProblemDto(id: id, requestId: requestId, photoPath: photoPath);
    }

    throw ArgumentError('Invalid JSON format for FullProblemDto: $json');
  }

  factory FullProblemDto.fromData(Problem companion) => FullProblemDto(
    id: companion.id,
    requestId: companion.requestId,
    photoPath: companion.photoPath,
  );
}
