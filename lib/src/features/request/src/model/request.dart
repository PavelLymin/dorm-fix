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

class RequestEntity {
  const RequestEntity({
    required this.id,
    required this.category,
    required this.description,
    required this.priority,
    required this.status,
    required this.studentAbsent,
    required this.dueDate,
    required this.createdAt,
  });

  final int id;
  final String category;
  final String description;
  final Priority priority;
  final String status;
  final bool studentAbsent;
  final DateTime dueDate;
  final DateTime createdAt;

  @override
  String toString() =>
      'RequestEntity('
      'id: $id,'
      'category: $category, '
      'description: $description, '
      'priority: $priority, '
      'status: $status, '
      'studentAbsent: $studentAbsent, '
      'dueDate: $dueDate, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RequestEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
