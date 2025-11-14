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

class UserEntity {
  const UserEntity({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    required this.role,
  });

  final String uid;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final String? photoURL;
  final Role role;

  UserEntity copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoURL,
    Role? role,
  }) => UserEntity(
    uid: uid ?? this.uid,
    displayName: displayName ?? this.displayName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    photoURL: photoURL ?? this.photoURL,
    role: role ?? this.role,
  );

  @override
  String toString() =>
      'UserEntity('
      'uid: $uid, '
      'displayName: $displayName, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'photoURL: $photoURL, '
      'role: $role)';

  @override
  bool operator ==(Object other) => other is UserEntity && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
