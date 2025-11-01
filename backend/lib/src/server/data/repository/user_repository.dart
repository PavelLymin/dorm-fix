import '../../../core/database/database.dart';
import '../../model/user.dart';
import '../dto/user.dart';

abstract interface class IUserRepository {
  Future<void> updateUser({required UserEntity user});
}

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({required Database database}) : _database = database;

  final Database _database;

  @override
  Future<void> updateUser({required UserEntity user}) async {
    await _database
        .update(_database.users)
        .replace(UserDto.fromEntity(user).toCompanion());
  }
}
