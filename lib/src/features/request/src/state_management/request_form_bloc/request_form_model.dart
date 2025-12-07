import '../../../request.dart';

class RequestFormModel {
  RequestFormModel({
    this.specializationId,
    this.description = '',
    this.priority = Priority.ordinary,
    this.studentAbsent = false,
    this.date,
    this.startTime,
    this.endTime,
    this.imagePaths = const [],
  });

  final int? specializationId;
  final String description;
  final Priority priority;
  final bool studentAbsent;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final List<String> imagePaths;

  String get displayDate {
    if (date == null) return 'Укажите дату';
    return date!.toLocal().toString();
  }

  String get displayTime {
    if (startTime == null || endTime == null) return 'Укажите время';
    return 'С $startTime до $endTime часов';
  }

  RequestFormModel copyWith({
    int? specializationId,
    String? description,
    Priority? priority,
    bool? studentAbsent,
    DateTime? date,
    String? startTime,
    String? endTime,
    List<String>? imagePaths,
  }) => RequestFormModel(
    specializationId: specializationId ?? this.specializationId,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    studentAbsent: studentAbsent ?? this.studentAbsent,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    imagePaths: imagePaths ?? this.imagePaths,
  );

  String? messageError;

  void checkError() {
    if (specializationId == null) messageError = 'Выберите мастера';
    if (description.trim().isEmpty) messageError = 'Опишите проблему';
    if (date == null) messageError = 'Укажите дату';
    if (startTime == null || endTime == null) messageError = 'Укажите время';
  }

  CreatedRequestEntity toEntity() {
    checkError();
    if (messageError != null) throw ArgumentError(messageError);

    return CreatedRequestEntity(
      specializationId: specializationId!,
      description: description,
      priority: priority,
      studentAbsent: studentAbsent,
      date: date!,
      startTime: int.parse(startTime!),
      endTime: int.parse(endTime!),
      imagePaths: List.unmodifiable(imagePaths),
    );
  }

  @override
  String toString() =>
      'RequestFormModel('
      'specializationId: $specializationId, '
      'description: $description, '
      'priority: $priority, '
      'studentAbsent: $studentAbsent, '
      'date: $date, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'imagePaths: $imagePaths)';
}
