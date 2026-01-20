import '../../model/repair_request.dart';
import 'problem.dart';

sealed class RepairRequestDto {
  const RepairRequestDto({
    required this.specializationId,
    required this.description,
    required this.priority,
    required this.status,
    required this.studentAbsent,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  final int specializationId;
  final String description;
  final Priority priority;
  final Status status;
  final bool studentAbsent;
  final DateTime date;
  final int startTime;
  final int endTime;

  factory RepairRequestDto.created({
    required int specializationId,
    required String description,
    required Priority priority,
    required Status status,
    required bool studentAbsent,
    required DateTime date,
    required int startTime,
    required int endTime,
    required List<String> imagePaths,
  }) => CreatedRepairRequestDto(
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
    required int specializationId,
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
    specializationId: specializationId,
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
}

final class CreatedRepairRequestDto extends RepairRequestDto {
  const CreatedRepairRequestDto({
    required super.specializationId,
    required super.description,
    required super.priority,
    required super.status,
    required super.studentAbsent,
    required super.date,
    required super.startTime,
    required super.endTime,
    required this.imagePaths,
  });

  final List<String> imagePaths;

  CreatedRepairRequest toEntity() => CreatedRepairRequest(
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

  factory CreatedRepairRequestDto.fromEntity(CreatedRepairRequest entity) =>
      CreatedRepairRequestDto(
        specializationId: entity.specializationId,
        description: entity.description,
        priority: entity.priority,
        status: entity.status,
        studentAbsent: entity.studentAbsent,
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        imagePaths: entity.imagePaths,
      );

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

  factory CreatedRepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'specialization_id': final int specializationId,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final bool studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<dynamic> imagePaths,
    }) {
      return CreatedRepairRequestDto(
        specializationId: specializationId,
        description: description,
        priority: Priority.fromValue(priority),
        status: Status.fromValue(status),
        studentAbsent: studentAbsent,
        date: DateTime.parse(date),
        startTime: startTime,
        endTime: endTime,
        imagePaths: imagePaths.cast<String>(),
      );
    } else {
      throw ArgumentError('Invalid JSON format for FullRequestEntity: $json');
    }
  }
}

final class FullRepairRequestDto extends RepairRequestDto {
  const FullRepairRequestDto({
    required this.id,
    required this.uid,
    required super.specializationId,
    required super.description,
    required super.priority,
    required super.status,
    required super.studentAbsent,
    required super.date,
    required super.startTime,
    required super.endTime,
    required this.problems,
    required this.createdAt,
  });

  final int id;
  final String uid;
  final DateTime createdAt;
  final List<ProblemDto> problems;

  FullRepairRequest toEntity() => FullRepairRequest(
    id: id,
    uid: uid,
    specializationId: specializationId,
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

  factory FullRepairRequestDto.fromEntity(FullRepairRequest entity) =>
      FullRepairRequestDto(
        id: entity.id,
        uid: entity.uid,
        specializationId: entity.specializationId,
        description: entity.description,
        priority: entity.priority,
        status: entity.status,
        studentAbsent: entity.studentAbsent,
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        problems: entity.problems.map(ProblemDto.fromEntity).toList(),
        createdAt: entity.createdAt,
      );

  Map<String, Object?> toJson() => {
    'id': id,
    'uid': uid,
    'specialization_id': specializationId,
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

  factory FullRepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'uid': final String uid,
      'specialization_id': final int specializationId,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final bool studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<dynamic> problems,
      'created_at': final String createdAt,
    }) {
      return FullRepairRequestDto(
        id: id,
        uid: uid,
        specializationId: specializationId,
        description: description,
        priority: Priority.fromValue(priority),
        status: Status.fromValue(status),
        studentAbsent: studentAbsent,
        date: DateTime.parse(date),
        startTime: startTime,
        endTime: endTime,
        problems: problems
            .cast<Map<String, Object?>>()
            .map(ProblemDto.fromJson)
            .toList(),
        createdAt: DateTime.parse(createdAt),
      );
    } else {
      throw ArgumentError('Invalid JSON format for FullRequestEntity: $json');
    }
  }
}
