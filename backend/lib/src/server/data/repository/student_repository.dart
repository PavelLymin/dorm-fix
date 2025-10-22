import '../../model/student.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({required StudentEntity student});

  Future<void> deleteStudent({required int id});

  Future<StudentEntity?> getStudent({required int id});

  Future<void> updateStudent({required StudentEntity student});
}

class StudentRepositoryImpl implements IStudentRepository {
  @override
  Future<void> createStudent({required StudentEntity student}) {
    // TODO: implement createStudent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteStudent({required int id}) {
    // TODO: implement deleteStudent
    throw UnimplementedError();
  }

  @override
  Future<StudentEntity?> getStudent({required int id}) {
    // TODO: implement getStudent
    throw UnimplementedError();
  }

  @override
  Future<void> updateStudent({required StudentEntity student}) {
    // TODO: implement updateStudent
    throw UnimplementedError();
  }
}
