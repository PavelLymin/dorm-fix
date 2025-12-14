import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../request.dart';

sealed class RequestDto {
  const RequestDto({
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

  RequestEntity toEntity();

  Map<String, Object?> toJson();
}

final class CreatedRequestDto extends RequestDto {
  const CreatedRequestDto({
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

  @override
  CreatedRequestEntity toEntity() => CreatedRequestEntity(
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

  factory CreatedRequestDto.fromEntity(CreatedRequestEntity entity) =>
      CreatedRequestDto(
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

  factory CreatedRequestDto.fromJson(Map<String, Object?> json) {
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
      return CreatedRequestDto(
        specializationId: specializationId,
        description: description,
        priority: Priority.fromValue(priority),
        status: Status.fromValue(status),
        studentAbsent: studentAbsent,
        date: DateTime.parse(date),
        startTime: startTime,
        endTime: endTime,
        imagePaths: imagePaths.cast<String>().toList(),
      );
    } else {
      throw ArgumentError('Invalid JSON format for FullRequestEntity: $json');
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

final class FullRequestDto extends RequestDto {
  const FullRequestDto({
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
    required this.imagePaths,
    required this.createdAt,
  });

  final int id;
  final String uid;
  final DateTime createdAt;
  final List<ProblemDto> imagePaths;

  @override
  FullRequestEntity toEntity() => FullRequestEntity(
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
    imagePaths: imagePaths.map((e) => e.toEntity()).toList(),
    createdAt: createdAt,
  );

  factory FullRequestDto.fromEntity(FullRequestEntity entity) => FullRequestDto(
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
    imagePaths: entity.imagePaths.map((e) => ProblemDto.fromEntity(e)).toList(),
    createdAt: entity.createdAt,
  );

  @override
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
    'problems': imagePaths.map((e) => e.toJson()).toList(),
    'created_at': createdAt.toLocal().toString(),
  };

  factory FullRequestDto.fromJson(
    Map<String, Object?> requestJson,
    List<Map<String, Object?>> problemsJson,
  ) {
    if (requestJson case <String, Object?>{
      'id': final int id,
      'uid': final String uid,
      'specialization_id': final int specializationId,
      'description': final String description,
      'priority': final String priority,
      'status': final String status,
      'student_absent': final int studentAbsent,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'created_at': final String createdAt,
    }) {
      return FullRequestDto(
        id: id,
        uid: uid,
        specializationId: specializationId,
        description: description,
        priority: Priority.fromValue(priority),
        status: Status.fromValue(status),
        studentAbsent: studentAbsent == 1,
        date: DateTime.parse(date),
        startTime: startTime,
        endTime: endTime,
        imagePaths: problemsJson.map(ProblemDto.fromJson).toList(),
        createdAt: DateTime.parse(createdAt),
      );
    } else {
      throw ArgumentError(
        'Invalid JSON format for FullRequestEntity: $requestJson',
      );
    }
  }

  factory FullRequestDto.fromData(Request request, List<Problem> problem) =>
      FullRequestDto(
        id: request.id,
        uid: request.uid,
        specializationId: request.specializationId,
        description: request.description,
        priority: Priority.fromValue(request.priority),
        status: Status.fromValue(request.status),
        studentAbsent: request.studentAbsent,
        date: request.date,
        startTime: request.startTime,
        endTime: request.endTime,
        imagePaths: problem.map((e) => ProblemDto.fromData(e)).toList(),
        createdAt: request.createdAt,
      );
}
