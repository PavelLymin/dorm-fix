import '../../../chat/chat.dart';
import '../../../profile/profile.dart';
import '../../../specialization/specialization.dart';
import '../../repair_request.dart';
import 'status.dart';

enum Priority {
  ordinary(value: 'Обычный'),
  high(value: 'Высокий');

  const Priority({required this.value});
  final String value;

  factory Priority.fromValue(String priority) {
    return values.firstWhere(
      (element) => element.value == priority,
      orElse: () => throw FormatException('Unknown priority: $priority'),
    );
  }
}

sealed class RepairRequestEntity {
  const RepairRequestEntity({
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

  const factory RepairRequestEntity.partial({
    required final int specId,
    required final String description,
    required final Priority priority,
    required final StatusEnum currentStatus,
    required final List<StatusEntity> status,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<String> problems,
  }) = PartialRepairRequest;

  const factory RepairRequestEntity.full({
    required final String description,
    required final Priority priority,
    required final StatusEnum currentStatus,
    required final List<StatusEntity> status,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final int id,
    required final FullStudent student,
    required final SpecializationEntity specialization,
    required final List<FullProblem> problems,
    required final FullChat chat,
    required final MasterEntity? master,
    required final DateTime createdAt,
  }) = FullRepairRequest;
}

final class PartialRepairRequest extends RepairRequestEntity {
  const PartialRepairRequest({
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
  final List<StatusEntity> status;
  final List<String> problems;

  PartialRepairRequest copyWith({
    int? specId,
    String? description,
    Priority? priority,
    List<StatusEntity>? status,
    DateTime? date,
    int? startTime,
    int? endTime,
    StatusEnum? currentStatus,
    List<String>? problems,
  }) => PartialRepairRequest(
    specId: specId ?? this.specId,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    currentStatus: currentStatus ?? this.currentStatus,
    problems: problems ?? this.problems,
  );

  @override
  String toString() =>
      'PartialRepairRequest('
      'specId: $specId, '
      'description: $description, '
      'status: $status, '
      'priority: $priority, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'currentStatus: $currentStatus, '
      'problems: $problems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PartialRepairRequest &&
        other.specId == specId &&
        other.description == description &&
        other.status == status &&
        other.priority == priority &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.currentStatus == currentStatus &&
        other.problems == problems;
  }

  @override
  int get hashCode => Object.hash(
    specId,
    description,
    status,
    priority,
    date,
    startTime,
    endTime,
    currentStatus,
    problems,
  );
}

final class FullRepairRequest extends RepairRequestEntity {
  const FullRepairRequest({
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
  final FullStudent student;
  final SpecializationEntity specialization;
  final List<StatusEntity> status;
  final List<FullProblem> problems;
  final FullChat chat;
  final MasterEntity? master;
  final DateTime createdAt;

  FullRepairRequest copyWith({
    String? description,
    Priority? priority,
    List<StatusEntity>? status,
    DateTime? date,
    int? startTime,
    int? endTime,
    StatusEnum? currentStatus,
    int? id,
    FullStudent? student,
    SpecializationEntity? specialization,
    List<FullProblem>? problems,
    FullChat? chat,
    MasterEntity? master,
    DateTime? createdAt,
  }) => FullRepairRequest(
    id: id ?? this.id,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    currentStatus: currentStatus ?? this.currentStatus,
    endTime: endTime ?? this.endTime,
    student: student ?? this.student,
    specialization: specialization ?? this.specialization,
    problems: problems ?? this.problems,
    chat: chat ?? this.chat,
    master: master ?? this.master,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() =>
      'FullRepairRequest('
      'id: $id, '
      'description: $description, '
      'priority: $priority, '
      'status: $status, '
      'currentStatus: $currentStatus, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'student: $student, '
      'specialization: $specialization, '
      'problems: $problems, '
      'chat: $chat, '
      'master: $master, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FullRepairRequest && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
