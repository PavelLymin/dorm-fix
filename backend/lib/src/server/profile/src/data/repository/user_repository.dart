import '../../../../../core/database/database.dart';
import '../../../profile.dart';

abstract interface class IUserRepository {
  Future<void> updateUser({required String uid, required UserEntity user});

  Future<bool> checkUserByUid({required String uid});

  Future<bool> checkUserByEmail({required String email});
}

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({required Database database}) : _database = database;

  final Database _database;

  @override
  Future<void> updateUser({
    required String uid,
    required UserEntity user,
  }) async {
    await (_database.update(_database.users)
          ..where((row) => row.uid.equals(uid)))
        .replace(UserDto.fromEntity(user).toCompanion());
  }

  @override
  Future<bool> checkUserByUid({required String uid}) async {
    final data = await (_database.select(
      _database.users,
    )..where((row) => row.uid.equals(uid))).getSingleOrNull();

    return data == null ? false : true;
  }

  @override
  Future<bool> checkUserByEmail({required String email}) async {
    final data = await (_database.select(
      _database.users,
    )..where((row) => row.email.equals(email))).getSingleOrNull();

    return data == null ? false : true;
  }
}
