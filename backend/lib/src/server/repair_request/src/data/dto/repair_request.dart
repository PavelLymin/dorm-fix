import 'dart:convert';

import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../../specialization/specialization.dart';
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
    required final SpecializationDto specialization,
    required final String description,
    required final Priority priority,
    required final Status status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<FullProblemDto> problems,
    required final DateTime createdAt,
  }) = FullRepairRequestDto;
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

  PartialRepairRequestEntity toEntity() => PartialRepairRequestEntity(
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

  factory PartialRepairRequestDto.fromEntity(
    PartialRepairRequestEntity entity,
  ) => PartialRepairRequestDto(
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
      throw ArgumentError(
        'Invalid JSON format for PartialRepairRequestDto: $json',
      );
    }
  }

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
  final List<FullProblemDto> problems;

  FullRepairRequestEntity toEntity() => FullRepairRequestEntity(
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
    problems: problems.map((p) => p.toEntity()).toList(),
    createdAt: createdAt,
  );

  factory FullRepairRequestDto.fromEntity(FullRepairRequestEntity entity) =>
      FullRepairRequestDto(
        id: entity.id,
        uid: entity.uid,
        specialization: SpecializationDto.fromEntity(entity.specialization),
        description: entity.description,
        priority: entity.priority,
        status: entity.status,
        studentAbsent: entity.studentAbsent,
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        problems: entity.problems.map(FullProblemDto.fromEntity).toList(),
        createdAt: entity.createdAt,
      );

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
    'problems': problems.map((p) => p.toJson()).toList(),
    'created_at': createdAt.toLocal().toString(),
  };

  factory FullRepairRequestDto.fromJson(Map<String, Object?> requestJson) {
    if (requestJson case <String, Object?>{
      'id': final int id,
      'uid': final String uid,
      'specialization': final String specJson,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final int studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final String problemsJson,
      'created_at': final String createdAt,
    }) {
      final specRaw = jsonDecode(specJson) as Map<String, Object?>;
      final problemsRaw = jsonDecode(problemsJson) as List<Object?>;
      return FullRepairRequestDto(
        id: id,
        uid: uid,
        specialization: .fromJson(specRaw),
        description: description,
        priority: .fromValue(priority),
        status: .fromValue(status),
        studentAbsent: studentAbsent == 1,
        date: .parse(date),
        startTime: startTime,
        endTime: endTime,
        problems: problemsRaw
            .whereType<Map<String, Object?>>()
            .map(FullProblemDto.fromJson)
            .toList(),
        createdAt: .parse(createdAt),
      );
    } else {
      throw ArgumentError(
        'Invalid JSON format for FullRepairRequestDto: $requestJson',
      );
    }
  }

  factory FullRepairRequestDto.fromData(
    Request request,
    Specialization specialization,
    List<Problem> problem,
  ) => FullRepairRequestDto(
    id: request.id,
    uid: request.uid,
    specialization: .fromData(specialization),
    description: request.description,
    priority: .fromValue(request.priority),
    status: .fromValue(request.status),
    studentAbsent: request.studentAbsent,
    date: request.date,
    startTime: request.startTime,
    endTime: request.endTime,
    problems: problem.map(FullProblemDto.fromData).toList(),
    createdAt: request.createdAt,
  );
}
