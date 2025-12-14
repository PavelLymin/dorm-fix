import 'problem.dart';

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

enum Status {
  newRequest(value: 'Создан'),
  inProgress(value: 'В работе'),
  completed(value: 'Выполнен');

  const Status({required this.value});
  final String value;

  factory Status.fromValue(String status) {
    return Status.values.firstWhere(
      (element) => element.value == status,
      orElse: () => throw FormatException('Unknown status: $status'),
    );
  }
}

sealed class RequestEntity {
  const RequestEntity({
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

  const factory RequestEntity.created({
    required final int specializationId,
    required final String description,
    required final Priority priority,
    required final Status status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<String> imagePaths,
  }) = CreatedRequestEntity;

  const factory RequestEntity.full({
    required final int id,
    required final String uid,
    required final int specializationId,
    required final String description,
    required final Priority priority,
    required final Status status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<ProblemEntity> imagePaths,
    required final DateTime createdAt,
  }) = FullRequestEntity;

  RequestEntity copyWith();
}

final class CreatedRequestEntity extends RequestEntity {
  const CreatedRequestEntity({
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
  CreatedRequestEntity copyWith({
    int? specializationId,
    String? description,
    Priority? priority,
    Status? status,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<String>? imagePaths,
  }) => CreatedRequestEntity(
    specializationId: specializationId ?? this.specializationId,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    studentAbsent: studentAbsent ?? this.studentAbsent,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    imagePaths: imagePaths ?? this.imagePaths,
  );

  @override
  String toString() =>
      'CreatedRequestEntity('
      'specializationId: $specializationId, '
      'description: $description, '
      'priority: $priority, '
      'studentAbsent: $studentAbsent, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'imagePaths: $imagePaths)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreatedRequestEntity &&
        other.specializationId == specializationId &&
        other.description == description &&
        other.priority == priority &&
        other.studentAbsent == studentAbsent &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.imagePaths == imagePaths;
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
    imagePaths,
  );
}

final class FullRequestEntity extends RequestEntity {
  const FullRequestEntity({
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
  final List<ProblemEntity> imagePaths;

  @override
  FullRequestEntity copyWith({
    int? id,
    String? uid,
    int? specializationId,
    String? description,
    Priority? priority,
    Status? status,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<ProblemEntity>? imagePaths,
    DateTime? createdAt,
  }) => FullRequestEntity(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    specializationId: specializationId ?? this.specializationId,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    studentAbsent: studentAbsent ?? this.studentAbsent,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    imagePaths: imagePaths ?? this.imagePaths,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() =>
      'RequestEntity('
      'id: $id,'
      'uid: $uid, '
      'specializationId: $specializationId, '
      'description: $description, '
      'priority: $priority, '
      'status: $status, '
      'studentAbsent: $studentAbsent, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'imagePaths: $imagePaths, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FullRequestEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
