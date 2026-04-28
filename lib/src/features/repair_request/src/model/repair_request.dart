import '../../../chat/chat.dart';
import '../../../profile/profile.dart';
import '../../../specialization/specialization.dart';
import 'problem.dart';
import 'status.dart';

enum Priority {
  ordinary(value: 'Обычный'),
  high(value: 'Высокий');

  const Priority({required this.value});
  final String value;

  factory Priority.fromValue(String priority) {
    return Priority.values.firstWhere(
      (element) => element.value == priority,
      orElse: () => throw FormatException('Unknown priority: $priority'),
    );
  }
}

sealed class RepairRequestEntity {
  const RepairRequestEntity({
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

  const factory RepairRequestEntity.partial({
    required final int specId,
    required final String description,
    required final Priority priority,
    required final StatusEnum currentStatus,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<String> problems,
  }) = PartialRepairRequest;

  const factory RepairRequestEntity.full({
    required final int id,
    required final FullStudent student,
    required final String description,
    required final Priority priority,
    required final StatusEnum currentStatus,
    required final List<StatusEntity> status,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final SpecializationEntity specialization,
    required final List<FullProblem> problems,
    required final ChatEntity chat,
    required final MasterUser? master,
    required final DateTime createdAt,
  }) = FullRepairRequest;

  RepairRequestEntity copyWith({
    String? description,
    Priority? priority,
    StatusEnum? currentStatus,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
  });
}

final class PartialRepairRequest extends RepairRequestEntity {
  const PartialRepairRequest({
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
  PartialRepairRequest copyWith({
    int? specId,
    String? description,
    Priority? priority,
    StatusEnum? currentStatus,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<String>? problems,
  }) => PartialRepairRequest(
    specId: specId ?? this.specId,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    currentStatus: currentStatus ?? this.currentStatus,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    problems: problems ?? this.problems,
  );

  @override
  String toString() =>
      'CreatedRepairRequest('
      'specId: $specId, '
      'description: $description, '
      'priority: $priority, '
      'currentStatus: $currentStatus, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'problems: $problems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PartialRepairRequest &&
        other.specId == specId &&
        other.description == description &&
        other.priority == priority &&
        other.currentStatus == currentStatus &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.problems == problems;
  }

  @override
  int get hashCode => Object.hash(
    specId,
    description,
    priority,
    currentStatus,
    date,
    startTime,
    endTime,
    problems,
  );
}

final class FullRepairRequest extends RepairRequestEntity {
  const FullRepairRequest({
    required this.id,
    required this.student,
    required super.description,
    required super.priority,
    required super.currentStatus,
    required super.date,
    required super.startTime,
    required super.endTime,
    required this.status,
    required this.specialization,
    required this.problems,
    required this.chat,
    required this.master,
    required this.createdAt,
  });

  final int id;
  final FullStudent student;
  final DateTime createdAt;
  final SpecializationEntity specialization;
  final List<FullProblem> problems;
  final List<StatusEntity> status;
  final ChatEntity chat;
  final MasterUser? master;

  @override
  FullRepairRequest copyWith({
    int? id,
    FullStudent? student,
    String? description,
    Priority? priority,
    StatusEnum? currentStatus,
    List<StatusEntity>? status,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    SpecializationEntity? specialization,
    List<FullProblem>? problems,
    ChatEntity? chat,
    MasterUser? master,
    DateTime? createdAt,
  }) => FullRepairRequest(
    id: id ?? this.id,
    student: student ?? this.student,
    specialization: specialization ?? this.specialization,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    currentStatus: currentStatus ?? this.currentStatus,
    status: status ?? this.status,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    problems: problems ?? this.problems,
    chat: chat ?? this.chat,
    master: master ?? this.master,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() =>
      'FullRepairRequest('
      'id: $id,'
      'student: $student, '
      'specialization: $specialization, '
      'description: $description, '
      'priority: $priority, '
      'current_status: $currentStatus, '
      'status: $status, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
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

final class FakeFullRepairRequest extends FullRepairRequest {
  FakeFullRepairRequest({
    super.id = 1,
    super.student = const .fake(),
    super.description = 'description',
    super.priority = .ordinary,
    super.currentStatus = .newRequest,
    super.status = const [],
    super.startTime = 0,
    super.endTime = 24,
    super.specialization = const .fake(),
    super.problems = const [],
    super.master,
  }) : super(date: .now(), chat: FakeFullChat(), createdAt: .now());
}
