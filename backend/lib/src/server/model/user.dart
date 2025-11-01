class UserEntity {
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.role,
  });

  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String photoURL;
  final String role;

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    String? photoURL,
    String? role,
  }) => UserEntity(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    photoURL: photoURL ?? this.photoURL,
    role: role ?? this.role,
  );

  @override
  String toString() =>
      'UserEntity('
      'uid: $uid, '
      'name: $name, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'photoURL: $photoURL, '
      'role: $role)';

  @override
  bool operator ==(Object other) => other is UserEntity && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
