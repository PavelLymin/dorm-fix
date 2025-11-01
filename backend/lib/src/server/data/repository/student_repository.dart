import 'package:backend/src/server/data/dto/student.dart';
import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../../model/student.dart';
import '../dto/user.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({required StudentEntity student});

  Future<void> deleteStudent({required String uid});

  Future<StudentEntity?> getStudent({required String uid});

  Future<void> updateStudent({required StudentEntity student});
}

class StudentRepositoryImpl implements IStudentRepository {
  StudentRepositoryImpl({required Database database}) : _database = database;

  final Database _database;

  @override
  Future<void> createStudent({required StudentEntity student}) async {
    await _database.transaction(() async {
      await _database
          .into(_database.users)
          .insert(UserDto.fromEntity(student.user).toCompanion());

      await _database
          .into(_database.students)
          .insert(StudentDto.fromEntity(student).toCompanion());
    });
  }

  @override
  Future<void> deleteStudent({required String uid}) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.users,
      )..where((row) => row.uid.equals(uid))).go();

      await (_database.delete(
        _database.students,
      )..where((row) => row.uid.equals(uid))).go();
    });
  }

  @override
  Future<StudentEntity?> getStudent({required String uid}) async {
    final data = await (_database.select(_database.students).join([
      innerJoin(
        _database.users,
        _database.users.uid.equalsExp(_database.students.uid),
      ),
    ])..where(_database.students.uid.equals(uid))).getSingleOrNull();

    if (data == null) return null;

    final student = StudentDto.fromData(
      data.readTable(_database.students),
      data.readTable(_database.users),
    ).toEntity();

    return student;
  }

  @override
  Future<void> updateStudent({required StudentEntity student}) async {
    await _database
        .update(_database.students)
        .replace(StudentDto.fromEntity(student).toCompanion());
  }
}
