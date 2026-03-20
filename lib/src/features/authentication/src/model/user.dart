import '../../../dormitory/dormitory.dart';
import '../../../students/home/home.dart';
import '../../../room/room.dart';
import '../../../profile/profile.dart';

part 'firebase_user.dart';
part 'profile.dart';
part 'student.dart';
part 'master.dart';

enum Role {
  student(name: 'student'),
  master(name: 'master');

  const Role({required this.name});

  final String name;

  static Role fromString(String name) => values.firstWhere(
    (role) => role.name == name,
    orElse: () => throw FormatException('Unknown role: $name'),
  );

  T map<T>({required T Function() student, required T Function() master}) =>
      switch (this) {
        .student => student(),
        .master => master(),
      };
}

typedef UserEntityrMatch<R, U extends UserEntity> = R Function(U user);

sealed class UserEntity {
  const UserEntity();

  bool get isAuthenticated;
  bool get isNotAuthenticated;
  AuthenticatedUser? get authenticatedOrNull;

  R map<R>({
    required UserEntityrMatch<R, NotAuthenticatedUser> notAuthenticated,
    required UserEntityrMatch<R, AuthenticatedUser> authenticated,
  }) => switch (this) {
    NotAuthenticatedUser u => notAuthenticated(u),
    AuthenticatedUser u => authenticated(u),
  };
}

class NotAuthenticatedUser extends UserEntity {
  const NotAuthenticatedUser();

  @override
  AuthenticatedUser? get authenticatedOrNull => null;

  @override
  bool get isAuthenticated => false;

  @override
  bool get isNotAuthenticated => true;
}

typedef AuthenticatedUserMatch<R, U extends AuthenticatedUser> =
    R Function(U user);

sealed class AuthenticatedUser extends UserEntity {
  const AuthenticatedUser();

  const factory AuthenticatedUser.firebase({
    required String uid,
    required String? displayName,
    required String? photoURL,
    required String? email,
    required String? phoneNumber,
    required Role role,
  }) = FirebaseUser;

  const factory AuthenticatedUser.fake() = FirebaseUser.fake;

  R mapAuthUser<R>({
    required AuthenticatedUserMatch<R, FirebaseUser> firebase,
    required AuthenticatedUserMatch<R, ProfileUser> profile,
  }) => switch (this) {
    FirebaseUser u => firebase(u),
    ProfileUser u => profile(u),
  };

  String get uid;
  String? get displayName;
  String? get photoURL;
  String? get email;
  String? get phoneNumber;
  Role get role;
}
