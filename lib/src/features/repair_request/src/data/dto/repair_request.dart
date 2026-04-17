import '../../../../chat/chat.dart';
import '../../../../profile/profile.dart';
import '../../../../students/home/home.dart';
import '../../../request.dart';
import 'problem.dart';

sealed class RepairRequestDto {
  const RepairRequestDto({
    required this.description,
    required this.priority,
    required this.currentStatus,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  final String description;
  final Priority priority;
  final StatusEnum currentStatus;
  final DateTime date;
  final int startTime;
  final int endTime;

  Map<String, Object?> toJson();
  RepairRequestEntity toEntity();

  factory RepairRequestDto.partial({
    required int specId,
    required String description,
    required Priority priority,
    required StatusEnum currentStatus,
    required DateTime date,
    required int startTime,
    required int endTime,
    required List<String> problems,
  }) = PartialRepairRequestDto;

  factory RepairRequestDto.full({
    required int id,
    required FullStudentDto student,
    required SpecializationDto specialization,
    required String description,
    required Priority priority,
    required StatusEnum currentStatus,
    required List<StatusDto> status,
    required DateTime date,
    required int startTime,
    required int endTime,
    required List<FullProblemDto> problems,
    required FullChatDto chat,
    required MasterDto? master,
    required DateTime createdAt,
  }) = FullRepairRequestDto;
}

final class PartialRepairRequestDto extends RepairRequestDto {
  const PartialRepairRequestDto({
    required super.description,
    required super.priority,
    required super.currentStatus,
    required super.date,
    required super.startTime,
    required super.endTime,
    required this.specId,
    required this.problems,
  });

  final int specId;
  final List<String> problems;

  @override
  PartialRepairRequest toEntity() => PartialRepairRequest(
    specId: specId,
    description: description,
    priority: priority,
    currentStatus: currentStatus,
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
    'date': date.toLocal().toString(),
    'start_time': startTime,
    'end_time': endTime,
    'problems': problems,
  };

  factory PartialRepairRequestDto.fromEntity(PartialRepairRequest entity) =>
      PartialRepairRequestDto(
        specId: entity.specId,
        description: entity.description,
        priority: entity.priority,
        currentStatus: entity.currentStatus,
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
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<String> imagePaths,
    }) {
      return PartialRepairRequestDto(
        specId: specId,
        description: description,
        priority: .fromValue(priority),
        currentStatus: .fromString(currentStatus),
        date: .parse(date),
        startTime: startTime,
        endTime: endTime,
        problems: imagePaths,
      );
    }

    throw ArgumentError(
      'Invalid JSON format for PartialRepairRequestDto: $json',
    );
  }
}

final class FullRepairRequestDto extends RepairRequestDto {
  const FullRepairRequestDto({
    required super.description,
    required super.priority,
    required super.currentStatus,
    required super.date,
    required super.startTime,
    required super.endTime,
    required this.status,
    required this.id,
    required this.student,
    required this.specialization,
    required this.problems,
    required this.chat,
    required this.master,
    required this.createdAt,
  });

  final int id;
  final FullStudentDto student;
  final SpecializationDto specialization;
  final List<FullProblemDto> problems;
  final List<StatusDto> status;
  final FullChatDto chat;
  final MasterDto? master;
  final DateTime createdAt;

  @override
  FullRepairRequest toEntity() => FullRepairRequest(
    id: id,
    student: student.toEntity(),
    specialization: specialization.toEntity(),
    description: description,
    priority: priority,
    currentStatus: currentStatus,
    status: status.map((e) => e.toEntity()).toList(),
    date: date,
    startTime: startTime,
    endTime: endTime,
    problems: problems.map((e) => e.toEntity()).toList(),
    chat: chat.toEntity(),
    master: master?.toEntity(),
    createdAt: createdAt,
  );

  @override
  Map<String, Object?> toJson() => {
    'id': id,
    'student': student.toJson(),
    'specialization': specialization.toJson(),
    'description': description,
    'priority': priority.value,
    'current_status': currentStatus.value,
    'status': status.map((e) => e.toJson()).toList(),
    'date': date.toLocal().toString(),
    'start_time': startTime,
    'end_time': endTime,
    'problems': problems,
    'chat': chat.toJson(),
    'master': master?.toJson(),
    'created_at': createdAt,
  };
  factory FullRepairRequestDto.fromEntity(FullRepairRequest entity) =>
      FullRepairRequestDto(
        id: entity.id,
        student: .fromEntity(entity.student),
        specialization: .fromEntity(entity.specialization),
        description: entity.description,
        priority: entity.priority,
        currentStatus: entity.currentStatus,
        status: entity.status.map(StatusDto.fromEntity).toList(),
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        problems: entity.problems.map(FullProblemDto.fromEntity).toList(),
        chat: .fromEntity(entity.chat),
        master: entity.master != null ? .fromEntity(entity.master!) : null,
        createdAt: entity.createdAt,
      );

  factory FullRepairRequestDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'student': final Map<String, Object?> student,
      'specialization': final Map<String, Object?> specialization,
      'description': final String description,
      'priority': final String priority,
      'current_status': final String currentStatus,
      'status': final List<Object?> status,
      'date': final String date,
      'start_time': final int startTime,
      'end_time': final int endTime,
      'problems': final List<Object?> problems,
      'chat': final Map<String, Object?> chat,
      'master': final Map<String, Object?>? master,
      'created_at': final String createdAt,
    }) {
      return FullRepairRequestDto(
        id: id,
        student: .fromJson(student),
        specialization: .fromJson(specialization),
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
        problems: problems
            .whereType<Map<String, Object?>>()
            .map(FullProblemDto.fromJson)
            .toList(),
        chat: .fromJson(chat),
        master: master != null ? .fromJson(master) : null,
        createdAt: DateTime.parse(createdAt),
      );
    }

    throw ArgumentError('Invalid JSON format for FullRepairRequestDto: $json');
  }
}
