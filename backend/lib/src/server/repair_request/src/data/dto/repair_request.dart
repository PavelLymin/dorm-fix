import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

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

  const factory RepairRequestDto.partial({
    required final int specializationId,
    required final String description,
    required final Priority priority,
    required final Status status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<PartialProblemDto> problems,
  }) = PartialRepairRequestDto;

  const factory RepairRequestDto.full({
    required final int id,
    required final String uid,
    required final String description,
    required final Priority priority,
    required final Status status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final DateTime createdAt,
  }) = FullRepairRequestDto;

  RepairRequestEntity toEntity();

  Map<String, Object?> toJson();
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
    required this.problems,
  });

  final int specializationId;
  final List<PartialProblemDto> problems;

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
    problems: problems.map((e) => e.toEntity()).toList(),
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
    'problems': problems.map((p) => p.toJson()).toList(),
  };

  RequestsCompanion toCompanion({required String uid}) => RequestsCompanion(
    uid: Value(uid),
    specializationId: Value(specializationId),
    description: Value(description),
    priority: Value(priority.value),
    status: Value(status.value),
    studentAbsent: Value(studentAbsent),
    date: Value(date),
    startTime: Value(startTime),
    endTime: Value(endTime),
  );

  factory PartialRepairRequestDto.fromEntity(PartialRepairRequest entity) =>
      PartialRepairRequestDto(
        specializationId: entity.specializationId,
        description: entity.description,
        priority: entity.priority,
        status: entity.status,
        studentAbsent: entity.studentAbsent,
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        problems: entity.problems.map(PartialProblemDto.fromEntity).toList(),
      );

  factory PartialRepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'specialization_id': final int specializationId,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final bool studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<Object?> problems,
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
        problems: problems
            .whereType<Map<String, Object?>>()
            .map(PartialProblemDto.fromJson)
            .toList(),
      );
    } else {
      throw ArgumentError('Invalid JSON format for RepairRequestDto: $json');
    }
  }
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
    required this.createdAt,
  });

  final int id;
  final String uid;
  final DateTime createdAt;

  @override
  FullRepairRequest toEntity() => FullRepairRequest(
    id: id,
    uid: uid,
    description: description,
    priority: priority,
    status: status,
    studentAbsent: studentAbsent,
    date: date,
    startTime: startTime,
    endTime: endTime,
    createdAt: createdAt,
  );

  @override
  Map<String, Object?> toJson() => {
    'id': id,
    'uid': uid,
    'description': description,
    'priority': priority.value,
    'status': status.value,
    'student_absent': studentAbsent,
    'date': date.toLocal().toString(),
    'start_time': startTime,
    'end_time': endTime,
    'created_at': createdAt.toLocal().toString(),
  };

  factory FullRepairRequestDto.fromEntity(FullRepairRequest entity) =>
      FullRepairRequestDto(
        id: entity.id,
        uid: entity.uid,
        description: entity.description,
        priority: entity.priority,
        status: entity.status,
        studentAbsent: entity.studentAbsent,
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        createdAt: entity.createdAt,
      );

  factory FullRepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'uid': final String uid,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final int studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'created_at': final String createdAt,
    }) {
      return FullRepairRequestDto(
        id: id,
        uid: uid,
        description: description,
        priority: .fromValue(priority),
        status: .fromValue(status),
        studentAbsent: studentAbsent == 1,
        date: .parse(date),
        startTime: startTime,
        endTime: endTime,
        createdAt: .parse(createdAt),
      );
    } else {
      throw ArgumentError(
        'Invalid JSON format for FullRepairRequestDto: $json',
      );
    }
  }

  factory FullRepairRequestDto.fromData(Request request) =>
      FullRepairRequestDto(
        id: request.id,
        uid: request.uid,
        description: request.description,
        priority: .fromValue(request.priority),
        status: .fromValue(request.status),
        studentAbsent: request.studentAbsent,
        date: request.date,
        startTime: request.startTime,
        endTime: request.endTime,
        createdAt: request.createdAt,
      );
}
