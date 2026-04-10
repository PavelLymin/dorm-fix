import '../../../request.dart';

class RequestFormModel {
  RequestFormModel({
    this.specializationId = 1,
    this.description = '',
    this.priority = .ordinary,
    this.status = .newRequest,
    this.studentAbsent = false,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    this.problems = const [],
  }) : date = date ?? WorkingDateTime().today,
       startTime = startTime ?? WorkingDateTime().start,
       endTime = endTime ?? WorkingDateTime().end;
  final int specializationId;
  final String description;
  final Priority priority;
  final Status status;
  final bool studentAbsent;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> problems;

  RequestFormModel copyWith({
    int? specializationId,
    String? description,
    Priority? priority,
    Status? status,
    bool? studentAbsent,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? problems,
  }) => RequestFormModel(
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

  String? checkError() {
    if (description.trim().isEmpty) return 'Опишите проблему';

    return null;
  }

  PartialRepairRequest toEntity() {
    final messageError = checkError();
    if (messageError != null) throw ArgumentError(messageError);

    return PartialRepairRequest(
      specId: specializationId,
      description: description,
      priority: priority,
      status: status,
      studentAbsent: studentAbsent,
      date: date,
      startTime: startTime.hour,
      endTime: endTime.hour,
      problems: problems.map((e) => e.split('/').last).toList(),
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
      'problems: $problems)';
}
