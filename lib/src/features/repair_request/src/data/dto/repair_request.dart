import '../../../../home/home.dart';
import '../../model/repair_request.dart';
import 'problem.dart';

sealed class RepairRequestDto {
  const RepairRequestDto({
    required this.description,
    required this.priority,
    required this.status,
    required this.studentAbsent,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  final String description;
  final Priority priority;
  final Status status;
  final bool studentAbsent;
  final DateTime date;
  final int startTime;
  final int endTime;

  Map<String, Object?> toJson();
  RepairRequestEntity toEntity();

  factory RepairRequestDto.partial({
    required int specializationId,
    required String description,
    required Priority priority,
    required Status status,
    required bool studentAbsent,
    required DateTime date,
    required int startTime,
    required int endTime,
    required List<String> imagePaths,
  }) => PartialRepairRequestDto(
    specializationId: specializationId,
    description: description,
    priority: priority,
    status: status,
    studentAbsent: studentAbsent,
    date: date,
    startTime: startTime,
    endTime: endTime,
    imagePaths: imagePaths,
  );

  factory RepairRequestDto.full({
    required int id,
    required String uid,
    required SpecializationDto specialization,
    required String description,
    required Priority priority,
    required Status status,
    required bool studentAbsent,
    required DateTime date,
    required int startTime,
    required int endTime,
    required List<ProblemDto> problems,
    required DateTime createdAt,
  }) => FullRepairRequestDto(
    id: id,
    uid: uid,
    specialization: specialization,
    description: description,
    priority: priority,
    status: status,
    studentAbsent: studentAbsent,
    date: date,
    startTime: startTime,
    endTime: endTime,
    problems: problems,
    createdAt: createdAt,
  );

  factory RepairRequestDto.fromEntity(RepairRequestEntity entity) =>
      switch (entity) {
        PartialRepairRequest _ => PartialRepairRequestDto(
          specializationId: entity.specializationId,
          description: entity.description,
          priority: entity.priority,
          status: entity.status,
          studentAbsent: entity.studentAbsent,
          date: entity.date,
          startTime: entity.startTime,
          endTime: entity.endTime,
          imagePaths: entity.imagePaths,
        ),
        FullRepairRequest _ => FullRepairRequestDto(
          id: entity.id,
          uid: entity.uid,
          specialization: .fromEntity(entity.specialization),
          description: entity.description,
          priority: entity.priority,
          status: entity.status,
          studentAbsent: entity.studentAbsent,
          date: entity.date,
          startTime: entity.startTime,
          endTime: entity.endTime,
          problems: entity.problems.map(ProblemDto.fromEntity).toList(),
          createdAt: entity.createdAt,
        ),
      };

  factory RepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'uid': final String uid,
      'specialization': final Map<String, Object?> specialization,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final bool studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<Object?> problems,
      'created_at': final String createdAt,
    }) {
      return FullRepairRequestDto(
        id: id,
        uid: uid,
        specialization: .fromJson(specialization),
        description: description,
        priority: .fromValue(priority),
        status: .fromValue(status),
        studentAbsent: studentAbsent,
        date: .parse(date),
        startTime: startTime,
        endTime: endTime,
        problems: problems
            .whereType<Map<String, Object?>>()
            .map(ProblemDto.fromJson)
            .toList(),
        createdAt: DateTime.parse(createdAt),
      );
    } else if (json case <String, Object?>{
      'specialization_id': final int specializationId,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final bool studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<Object?> imagePaths,
    }) {
      return PartialRepairRequestDto(
        specializationId: specializationId,
        description: description,
        priority: .fromValue(priority),
        status: .fromValue(status),
        studentAbsent: studentAbsent,
        date: .parse(date),
        startTime: startTime,
        endTime: endTime,
        imagePaths: imagePaths.whereType<String>().toList(),
      );
    }

    throw ArgumentError('Invalid JSON format for RepairRequestDto: $json');
  }
}

final class PartialRepairRequestDto extends RepairRequestDto {
  const PartialRepairRequestDto({
    required super.description,
    required super.priority,
    required super.status,
    required super.studentAbsent,
    required super.date,
    required super.startTime,
    required super.endTime,
    required this.specializationId,
    required this.imagePaths,
  });

  final int specializationId;
  final List<String> imagePaths;

  @override
  PartialRepairRequest toEntity() => PartialRepairRequest(
    specializationId: specializationId,
    description: description,
    priority: priority,
    status: status,
    studentAbsent: studentAbsent,
    date: date,
    startTime: startTime,
    endTime: endTime,
    imagePaths: imagePaths,
  );

  @override
  Map<String, Object?> toJson() => {
    'specialization_id': specializationId,
    'description': description,
    'priority': priority.value,
    'status': status.value,
    'student_absent': studentAbsent,
    'date': date.toLocal().toString(),
    'start_time': startTime,
    'end_time': endTime,
    'problems': imagePaths,
  };
}

final class FullRepairRequestDto extends RepairRequestDto {
  const FullRepairRequestDto({
    required this.id,
    required this.uid,
    required super.description,
    required super.priority,
    required super.status,
    required super.studentAbsent,
    required super.date,
    required super.startTime,
    required super.endTime,
    required this.specialization,
    required this.problems,
    required this.createdAt,
  });

  final int id;
  final String uid;
  final DateTime createdAt;
  final SpecializationDto specialization;
  final List<ProblemDto> problems;

  @override
  FullRepairRequest toEntity() => FullRepairRequest(
    id: id,
    uid: uid,
    specialization: specialization.toEntity(),
    description: description,
    priority: priority,
    status: status,
    studentAbsent: studentAbsent,
    date: date,
    startTime: startTime,
    endTime: endTime,
    problems: problems.map((e) => e.toEntity()).toList(),
    createdAt: createdAt,
  );

  @override
  Map<String, Object?> toJson() => {
    'id': id,
    'uid': uid,
    'specialization': specialization.toJson(),
    'description': description,
    'priority': priority.value,
    'status': status.value,
    'student_absent': studentAbsent,
    'date': date.toLocal().toString(),
    'start_time': startTime,
    'end_time': endTime,
    'problems': problems,
    'created_at': createdAt,
  };
}
