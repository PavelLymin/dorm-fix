enum Priority {
  ordinary(priority: 'Обычный'),
  high(priority: 'Высокий');

  const Priority({required this.priority});
  final String priority;

  factory Priority.fromValue(String priority) {
    return Priority.values.firstWhere(
      (element) => element.priority == priority,
      orElse: () => throw FormatException('Unknown priority: $priority'),
    );
  }
}

sealed class RequestEntity {
  const RequestEntity({
    required this.specializationId,
    required this.description,
    required this.priority,
    required this.studentAbsent,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.imagePaths,
  });

  final int specializationId;
  final String description;
  final Priority priority;
  final bool studentAbsent;
  final DateTime date;
  final int startTime;
  final int endTime;
  final List<String> imagePaths;

  const factory RequestEntity.full({
    required final int id,
    required final int specializationId,
    required final String description,
    required final Priority priority,
    required final String status,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<String> imagePaths,
    required final DateTime createdAt,
  }) = FullRequestEntity;

  const factory RequestEntity.created({
    required final int specializationId,
    required final String description,
    required final Priority priority,
    required final bool studentAbsent,
    required final DateTime date,
    required final int startTime,
    required final int endTime,
    required final List<String> imagePaths,
  }) = CreatedRequestEntity;
}

final class CreatedRequestEntity extends RequestEntity {
  const CreatedRequestEntity({
    required super.specializationId,
    required super.description,
    required super.priority,
    required super.studentAbsent,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.imagePaths,
  });

  CreatedRequestEntity copyWith({
    int? specializationId,
    String? description,
    Priority? priority,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<String>? imagePaths,
  }) => CreatedRequestEntity(
    specializationId: specializationId ?? this.specializationId,
    description: description ?? this.description,
    priority: priority ?? this.priority,
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
    required super.specializationId,
    required super.description,
    required super.priority,
    required this.status,
    required super.studentAbsent,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.imagePaths,
    required this.createdAt,
  });

  final int id;
  final String status;
  final DateTime createdAt;

  FullRequestEntity copyWith({
    int? id,
    int? specializationId,
    String? description,
    Priority? priority,
    String? status,
    bool? studentAbsent,
    DateTime? date,
    int? startTime,
    int? endTime,
    List<String>? imagePaths,
    DateTime? createdAt,
  }) => FullRequestEntity(
    id: id ?? this.id,
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
