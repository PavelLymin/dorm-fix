import '../../model/problem.dart';

class ProblemDto {
  ProblemDto({
    required this.id,
    required this.requestId,
    required this.photoPath,
  });

  final int id;
  final int requestId;
  final String photoPath;

  ProblemEntity toEntity() =>
      ProblemEntity(id: id, requestId: requestId, photoPath: photoPath);

  factory ProblemDto.fromEntity(ProblemEntity entity) => ProblemDto(
    id: entity.id,
    requestId: entity.requestId,
    photoPath: entity.photoPath,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'request_id': requestId,
    'photo_path': photoPath,
  };

  factory ProblemDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'request_id': final int requestId,
      'photo_path': final String photoPath,
    }) {
      return ProblemDto(id: id, requestId: requestId, photoPath: photoPath);
    } else {
      throw ArgumentError('Invalid problem JSON: $json');
    }
  }
}
