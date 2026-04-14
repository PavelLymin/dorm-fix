enum StatusEnum {
  newRequest(value: 'Создано'),
  inProgress(value: 'Передано мастеру'),
  completed(value: 'Завершено'),
  canceled(value: 'Отказано'),
  notDone(value: 'Не сделано');

  const StatusEnum({required this.value});
  final String value;

  factory StatusEnum.fromString(String status) {
    return StatusEnum.values.firstWhere(
      (element) => element.value == status,
      orElse: () => throw FormatException('Unknown status: $status'),
    );
  }
}

class StatusEntity {
  const StatusEntity({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  final int id;
  final StatusEnum title;
  final DateTime createdAt;

  StatusEntity copyWith({int? id, StatusEnum? title, DateTime? createdAt}) =>
      StatusEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  String toString() =>
      'StatusEntity('
      'id: $id, '
      'title: $title, '
      'createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StatusEntity && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
