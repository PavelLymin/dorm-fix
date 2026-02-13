import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../profile.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({
    required String uid,
    required PartialStudent student,
  });

  Future<void> deleteStudent({required String uid});

  Future<FullStudent?> getStudent({required String uid});

  Future<void> updateStudent({
    required String uid,
    required PartialStudent student,
  });
}

class StudentRepositoryImpl implements IStudentRepository {
  StudentRepositoryImpl({required Database database}) : _database = database;

  final Database _database;

  @override
  Future<void> createStudent({
    required String uid,
    required PartialStudent student,
  }) async {
    await _database.transaction(() async {
      await _database
          .into(_database.users)
          .insert(UserDto.fromEntity(student.user).toCompanion());
      await _database
          .into(_database.students)
          .insert(PartialStudentDto.fromEntity(student).toCompanion());
    });

    // await _firebaseApp.auth().setCustomUserClaims(uid, {
    //   'role': Role.student.name,
    // });
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
  Future<FullStudent?> getStudent({required String uid}) async {
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
    required PartialStudent student,
  }) async {
    await (_database.update(_database.students)
          ..where((row) => row.uid.equals(uid)))
        .replace(PartialStudentDto.fromEntity(student).toCompanion());
  }
}
