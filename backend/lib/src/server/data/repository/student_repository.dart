import 'package:backend/src/server/data/dto/student.dart';
import 'package:drift/drift.dart';
import 'package:firebase_admin/firebase_admin.dart';
import '../../../core/database/database.dart';
import '../../model/student.dart';
import '../../model/user.dart';
import '../dto/user.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({
    required String uid,
    required CreatedStudentEntity student,
  });

  Future<void> deleteStudent({required String uid});

  Future<FullStudentEntity?> getStudent({required String uid});

  Future<void> updateStudent({
    required String uid,
    required CreatedStudentEntity student,
  });
}

class StudentRepositoryImpl implements IStudentRepository {
  StudentRepositoryImpl({
    required Database database,
    required App firebaseAdmin,
  }) : _database = database,
       _firebaseApp = firebaseAdmin;

  final Database _database;
  final App _firebaseApp;

  @override
  Future<void> createStudent({
    required String uid,
    required CreatedStudentEntity student,
  }) async {
    await _database.transaction(() async {
      await _database
          .into(_database.users)
          .insert(UserDto.fromEntity(student.user).toCompanion());
      await _database
          .into(_database.students)
          .insert(CreatedStudentDto.fromEntity(student).toCompanion());
    });

    await _firebaseApp.auth().setCustomUserClaims(uid, {
      'role': Role.student.name,
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
  Future<FullStudentEntity?> getStudent({required String uid}) async {
    final data = await (_database.select(_database.students).join([
      innerJoin(
        _database.users,
        _database.users.uid.equalsExp(_database.students.uid),
      ),
      innerJoin(
        _database.dormitories,
        _database.dormitories.id.equalsExp(_database.students.dormitoryId),
      ),
      innerJoin(
        _database.rooms,
        _database.rooms.id.equalsExp(_database.students.roomId),
      ),
    ])..where(_database.students.uid.equals(uid))).getSingleOrNull();

    if (data == null) return null;

    final student = FullStudentDto.fromData(
      data.readTable(_database.students),
      data.readTable(_database.users),
      data.readTable(_database.dormitories),
      data.readTable(_database.rooms),
    ).toEntity();

    return student;
  }

  @override
  Future<void> updateStudent({
    required String uid,
    required CreatedStudentEntity student,
  }) async {
    await (_database.update(_database.students)
          ..where((row) => row.uid.equals(uid)))
        .replace(CreatedStudentDto.fromEntity(student).toCompanion());
  }
}
