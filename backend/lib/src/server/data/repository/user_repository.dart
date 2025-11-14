import '../../../core/database/database.dart';
import '../../model/user.dart';
import '../dto/user.dart';

abstract interface class IUserRepository {
  Future<void> updateUser({required String uid, required UserEntity user});

  Future<UserEntity?> getUserByUid({required String uid});

  Future<UserEntity?> getUserByEmail({required String email});
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
  Future<UserEntity?> getUserByUid({required String uid}) async {
    final data = await (_database.select(
      _database.users,
    )..where((row) => row.uid.equals(uid))).getSingleOrNull();

    if (data == null) return null;

    final user = UserDto.fromData(data).toEntity();

    return user;
  }

  @override
  Future<UserEntity?> getUserByEmail({required String email}) async {
    final data = await (_database.select(
      _database.users,
    )..where((row) => row.email.equals(email))).getSingleOrNull();

    if (data == null) return null;

    final user = UserDto.fromData(data).toEntity();

    return user;
  }
}
