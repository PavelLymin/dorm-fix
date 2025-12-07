// import '../../../request.dart';

// class RequestDto {
//   const RequestDto({
//     required this.id,
//     required this.category,
//     required this.description,
//     required this.priority,
//     required this.status,
//     required this.studentAbsent,
//     required this.dueDate,
//     required this.createdAt,
//   });

//   final int id;
//   final String category;
//   final String description;
//   final Priority priority;
//   final String status;
//   final bool studentAbsent;
//   final DateTime dueDate;
//   final DateTime createdAt;

//   RequestEntity toEntity() => RequestEntity(
//     id: id,
//     category: category,
//     description: description,
//     priority: priority,
//     status: status,
//     studentAbsent: studentAbsent,
//     dueDate: dueDate,
//     createdAt: createdAt,
//   );

//   factory RequestDto.fromEntity(RequestEntity entity) => RequestDto(
//     id: entity.id,
//     category: entity.category,
//     description: entity.description,
//     priority: entity.priority,
//     status: entity.status,
//     studentAbsent: entity.studentAbsent,
//     dueDate: entity.dueDate,
//     createdAt: entity.createdAt,
//   );

//   Map<String, Object?> toJson() => {
//     'id': id,
//     'category': category,
//     'description': description,
//     'priority': priority.priority,
//     'status': status,
//     'student_absent': studentAbsent,
//     'due_date': dueDate.toUtc().toIso8601String(),
//     'created_at': createdAt,
//   };

//   factory RequestDto.fromJson(Map<String, Object?> json) {
//     if (json case <String, Object?>{
//       'id': final int id,
//       'category': final String category,
//       'description': final String description,
//       'priority': final String priority,
//       'status': final String status,
//       'student_absent': final bool studentAbsent,
//       'due_date': final String dueDate,
//       'created_at': final String createdAt,
//     }) {
//       return RequestDto(
//         id: id,
//         category: category,
//         description: description,
//         priority: Priority.fromValue(priority),
//         status: status,
//         studentAbsent: studentAbsent,
//         dueDate: DateTime.parse(dueDate).toLocal(),
//         createdAt: DateTime.parse(createdAt).toLocal(),
//       );
//     }
//     throw ArgumentError('Invalid JSON format for Request: $json');
//   }
// }
