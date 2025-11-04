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
        Role.student => student(),
        Role.master => master(),
      };
}

abstract class UserEntity with _UserPatternMatching {
  const factory UserEntity.notAuthenticated() = NotAuthenticatedUser;

  const factory UserEntity.authenticated({
    required final String uid,
    required final String? displayName,
    required final String? photoURL,
    required final String? email,
    required final String? phoneNumber,
  }) = AuthenticatedUser;

  bool get isAuthenticated;

  bool get isNotAuthenticated;

  AuthenticatedUser? get authenticatedOrNull;
}

class NotAuthenticatedUser implements UserEntity {
  const NotAuthenticatedUser();

  @override
  bool get isAuthenticated => false;

  @override
  bool get isNotAuthenticated => true;

  @override
  AuthenticatedUser? get authenticatedOrNull => null;

  @override
  T map<T>({
    required T Function(NotAuthenticatedUser user) notAuthenticatedUser,
    required T Function(AuthenticatedUser user) authenticatedUser,
  }) => notAuthenticatedUser(this);

  @override
  String toString() => 'User is not authenticated';

  @override
  bool operator ==(final Object other) => other is NotAuthenticatedUser;

  @override
  int get hashCode => 0;
}

class AuthenticatedUser implements UserEntity {
  const AuthenticatedUser({
    required this.uid,
    required this.displayName,
    required this.photoURL,
    required this.email,
    required this.phoneNumber,
  });

  final String uid;
  final String? displayName;
  final String? photoURL;
  final String? email;
  final String? phoneNumber;

  @override
  bool get isAuthenticated => !isNotAuthenticated;

  @override
  bool get isNotAuthenticated => uid.isEmpty;

  @override
  AuthenticatedUser? get authenticatedOrNull =>
      isNotAuthenticated ? null : this;

  @override
  T map<T>({
    required T Function(NotAuthenticatedUser user) notAuthenticatedUser,
    required T Function(AuthenticatedUser user) authenticatedUser,
  }) => authenticatedUser(this);

  @override
  String toString() =>
      'UserEntity('
      'uid: $uid, '
      'name: $displayName, '
      'email: $email, '
      'phone: $phoneNumber)';

  @override
  bool operator ==(final Object other) =>
      other is AuthenticatedUser && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

mixin _UserPatternMatching {
  T map<T>({
    required T Function(NotAuthenticatedUser user) notAuthenticatedUser,
    required T Function(AuthenticatedUser user) authenticatedUser,
  });
}
