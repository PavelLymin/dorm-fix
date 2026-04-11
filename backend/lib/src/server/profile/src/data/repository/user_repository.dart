import 'package:drift/drift.dart';

import '../../../../../core/database/database.dart';
import '../../../profile.dart';

abstract interface class IUserRepository {
  Future<void> update({required UserEntity user});
}

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({required this._database});

  final Database _database;

  @override
  Future<void> update({required UserEntity user}) async {
    final dto = UserDto.fromEntity(user);
    await (_database.update(
      _database.users,
    )..where((row) => row.uid.equals(user.uid))).write(
      UsersCompanion(
        displayName: toValue(dto.displayName),
        photoURL: toValue(dto.photoURL),
        email: toValue(dto.email),
        phoneNumber: toValue(dto.phoneNumber),
        role: Value(dto.role.name),
      ),
    );
  }
}
