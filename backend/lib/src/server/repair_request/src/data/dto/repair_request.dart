import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../../chat/chat.dart';
import '../../../../profile/profile.dart';
import '../../../../specialization/specialization.dart';
import '../../../repair_request.dart';
import '../../model/status.dart';
import 'status.dart';

sealed class RepairRequestDto {
  const RepairRequestDto({
    required this.description,
    required this.priority,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.currentStatus,
  });

  final String description;
  final Priority priority;
  final DateTime date;
  final int startTime;
  final int endTime;
  final StatusEnum currentStatus;

  const factory RepairRequestDto.partial({
    required final int specId,
    required final String description,
    required final Priority priority,
    required final StatusEnum currentStatus,
    required final List<StatusDto> status,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<String> problems,
  }) = PartialRepairRequestDto;

  const factory RepairRequestDto.full({
    required final int id,
    required final String description,
    required final Priority priority,
    required final StatusEnum currentStatus,
    required final List<StatusDto> status,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final FullStudentDto student,
    required final SpecializationDto specialization,
    required final List<FullProblemDto> problems,
    required final FullChatDto chat,
    required final MasterDto? master,
    required final DateTime createdAt,
  }) = FullRepairRequestDto;

  RepairRequestEntity toEntity();

  Map<String, Object?> toJson();
}

final class PartialRepairRequestDto extends RepairRequestDto {
  const PartialRepairRequestDto({
    required super.description,
    required super.priority,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.currentStatus,
    required this.specId,
    required this.status,
    required this.problems,
  });

  final int specId;
  final List<StatusDto> status;
  final List<String> problems;

  @override
  PartialRepairRequest toEntity() => PartialRepairRequest(
    specId: specId,
    description: description,
    priority: priority,
    currentStatus: currentStatus,
    status: status.map((e) => e.toEntity()).toList(),
    date: date,
    startTime: startTime,
    endTime: endTime,
    problems: problems,
  );

  @override
  Map<String, Object?> toJson() => {
    'spec_id': specId,
    'description': description,
    'priority': priority.value,
    'current_status': currentStatus.value,
    'status': status.map((e) => e.toJson()).toList(),
    'date': date.toLocal().toString(),
    'start_time': startTime,
    'end_time': endTime,
    'problems': problems,
  };

  RequestsCompanion toCompanion({required String uid}) => RequestsCompanion(
    uid: Value(uid),
    specId: Value(specId),
    description: Value(description),
    priority: Value(priority.value),
    currentStatus: Value(currentStatus.value),
    date: Value(date),
    startTime: Value(startTime),
    endTime: Value(endTime),
  );

  factory PartialRepairRequestDto.fromEntity(PartialRepairRequest entity) =>
      PartialRepairRequestDto(
        specId: entity.specId,
        description: entity.description,
        priority: entity.priority,
        currentStatus: entity.currentStatus,
        status: entity.status.map(StatusDto.fromEntity).toList(),
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        problems: entity.problems,
      );

  factory PartialRepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'spec_id': final int specId,
      'description': final String description,
      'priority': final String priority,
      'current_status': final String currentStatus,
      'status': final List<Object?> status,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<Object?> problems,
    }) {
      return PartialRepairRequestDto(
        specId: specId,
        description: description,
        priority: .fromValue(priority),
        currentStatus: .fromString(currentStatus),
        status: status
            .whereType<Map<String, Object?>>()
            .map(StatusDto.fromJson)
            .toList(),
        date: .parse(date),
        startTime: startTime,
        endTime: endTime,
        problems: problems.whereType<String>().toList(),
      );
    }

    throw ArgumentError('Invalid JSON format for RepairRequestDto: $json');
  }
}

final class FullRepairRequestDto extends RepairRequestDto {
  const FullRepairRequestDto({
    required super.description,
    required super.priority,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.currentStatus,
    required this.id,
    required this.student,
    required this.specialization,
    required this.status,
    required this.problems,
    required this.chat,
    required this.master,
    required this.createdAt,
  });

  final int id;
  final FullStudentDto student;
  final SpecializationDto specialization;
  final List<StatusDto> status;
  final List<FullProblemDto> problems;
  final FullChatDto chat;
  final MasterDto? master;
  final DateTime createdAt;

  @override
  FullRepairRequest toEntity() => FullRepairRequest(
    id: id,
    description: description,
    priority: priority,
    currentStatus: currentStatus,
    status: status.map((e) => e.toEntity()).toList(),
    date: date,
    startTime: startTime,
    endTime: endTime,
    student: student.toEntity(),
    specialization: specialization.toEntity(),
    problems: problems.map((e) => e.toEntity()).toList(),
    chat: chat.toEntity(),
    master: master?.toEntity(),
    createdAt: createdAt,
  );

  @override
  Map<String, Object?> toJson() => {
    'id': id,
    'description': description,
    'priority': priority.value,
    'current_status': currentStatus.value,
    'status': status.map((e) => e.toJson()).toList(),
    'date': date.toLocal().toIso8601String(),
    'start_time': startTime,
    'end_time': endTime,
    'student': student.toJson(),
    'specialization': specialization.toJson(),
    'problems': problems.map((e) => e.toJson()).toList(),
    'chat': chat.toJson(),
    'master': master?.toJson(),
    'created_at': createdAt.toLocal().toIso8601String(),
  };

  factory FullRepairRequestDto.fromEntity(FullRepairRequest entity) =>
      FullRepairRequestDto(
        id: entity.id,
        description: entity.description,
        priority: entity.priority,
        currentStatus: entity.currentStatus,
        status: entity.status.map(StatusDto.fromEntity).toList(),
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        student: .fromEntity(entity.student),
        specialization: .fromEntity(entity.specialization),
        problems: entity.problems
            .map((e) => FullProblemDto.fromEntity(e))
            .toList(),
        chat: .fromEntity(entity.chat),
        master: entity.master != null ? .fromEntity(entity.master!) : null,
        createdAt: entity.createdAt,
      );

  factory FullRepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'description': final String description,
      'priority': final String priority,
      'current_status': final String currentStatus,
      'status': final List<Object?> status,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'student': final Map<String, Object?> student,
      'specialization': final Map<String, Object?> specialization,
      'problems': final List<Object?> problems,
      'chat': final Map<String, Object?> chat,
      'master': final Map<String, Object?>? master,
      'created_at': final String createdAt,
    }) {
      return FullRepairRequestDto(
        id: id,
        description: description,
        priority: .fromValue(priority),
        currentStatus: .fromString(currentStatus),
        status: status
            .whereType<Map<String, Object?>>()
            .map(StatusDto.fromJson)
            .toList(),
        date: .parse(date),
        startTime: startTime,
        endTime: endTime,
        student: .fromJson(student),
        specialization: .fromJson(specialization),
        problems: problems
            .whereType<Map<String, Object?>>()
            .map((e) => FullProblemDto.fromJson(e))
            .toList(),
        chat: .fromJson(chat),
        master: master != null ? .fromJson(master) : null,
        createdAt: .parse(createdAt),
      );
    }

    throw ArgumentError('Invalid JSON format for FullRepairRequestDto: $json');
  }

  factory FullRepairRequestDto.fromData({
    required Request request,
    required FullStudentDto student,
    required List<StatusDto> status,
    required SpecializationDto specialization,
    required List<FullProblemDto> problems,
    required FullChatDto chat,
    MasterDto? master,
  }) => FullRepairRequestDto(
    id: request.id,
    description: request.description,
    priority: .fromValue(request.priority),
    currentStatus: .fromString(request.currentStatus),
    status: status,
    date: request.date,
    startTime: request.startTime,
    endTime: request.endTime,
    student: student,
    specialization: specialization,
    problems: problems,
    chat: chat,
    master: master,
    createdAt: request.createdAt,
  );
}
