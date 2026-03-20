import '../../../../../core/database/database.dart';
import '../../../profile.dart';

abstract interface class IUserRepository {
  Future<void> updateUser({required String uid, required UserEntity user});
}

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({required this._database});

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
}
