import '../../../specialization/specialization.dart';
import 'problem.dart';

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

enum Status {
  newRequest(value: 'Создан'),
  inProgress(value: 'В работе'),
  completed(value: 'Выполнен');

  const Status({required this.value});
  final String value;

  factory Status.fromValue(String status) {
    return values.firstWhere(
      (element) => element.value == status,
      orElse: () => throw FormatException('Unknown status: $status'),
    );
  }
}

sealed class RepairRequestEntity {
  const RepairRequestEntity({
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

  const factory RepairRequestEntity.partial({
    required final int specializationId,
    required final String description,
    required final Priority priority,
    required final Status status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<PartialProblemEntity> problems,
  }) = PartialRepairRequest;

  const factory RepairRequestEntity.full({
    required final int id,
    required final String uid,
    required final SpecializationEntity specialization,
    required final String description,
    required final Priority priority,
    required final Status status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<FullProblemEntity> problems,
    required final DateTime createdAt,
  }) = FullRepairRequest;
}

final class PartialRepairRequest extends RepairRequestEntity {
  const PartialRepairRequest({
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
  final List<PartialProblemEntity> problems;

  PartialRepairRequest copyWith({
    int? specializationId,
    String? description,
    Priority? priority,
    Status? status,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<PartialProblemEntity>? problems,
  }) => PartialRepairRequest(
    specializationId: specializationId ?? this.specializationId,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    studentAbsent: studentAbsent ?? this.studentAbsent,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    problems: problems ?? this.problems,
  );

  @override
  String toString() =>
      'PartialRepairRequest('
      'specializationId: $specializationId, '
      'description: $description, '
      'priority: $priority, '
      'studentAbsent: $studentAbsent, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'problems: $problems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PartialRepairRequest &&
        other.specializationId == specializationId &&
        other.description == description &&
        other.priority == priority &&
        other.studentAbsent == studentAbsent &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.problems == problems;
  }

  @override
  int get hashCode => Object.hash(
    specializationId,
    description,
    priority,
    studentAbsent,
    date,
    startTime,
    endTime,
    problems,
  );
}

final class FullRepairRequest extends RepairRequestEntity {
  const FullRepairRequest({
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
  final SpecializationEntity specialization;
  final List<FullProblemEntity> problems;

  FullRepairRequest copyWith({
    int? id,
    String? uid,
    SpecializationEntity? specialization,
    String? description,
    Priority? priority,
    Status? status,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<FullProblemEntity>? problems,
    DateTime? createdAt,
  }) => FullRepairRequest(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    specialization: specialization ?? this.specialization,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    studentAbsent: studentAbsent ?? this.studentAbsent,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    problems: problems ?? this.problems,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() =>
      'FullRepairRequest('
      'id: $id,'
      'uid: $uid, '
      'specialization: $specialization, '
      'description: $description, '
      'priority: $priority, '
      'status: $status, '
      'studentAbsent: $studentAbsent, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'problems: $problems, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FullRepairRequest && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
